import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/pages/Deal/deal_page.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/application/bloc/appBloc.dart';
import 'package:flutterdealapp/pages/application/bloc/appEvent.dart';
import 'package:flutterdealapp/pages/common_widgets.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_event.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
import 'package:geolocator/geolocator.dart';

import '../../values/color.dart';

class postDetailPage extends StatefulWidget {
  const postDetailPage({super.key});

  @override
  State<postDetailPage> createState() => _postDetailPageState();
}

Future<void> getLocation() async {
  // await Geolocator.checkPermission();
  // await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  print(position);
  currentLatitude = position.latitude;
  currentLongtitude = position.longitude;
}

double currentLatitude = 0;
double currentLongtitude = 0;

calculateDistances(double curLa, double CurLong, double la, double long) {
  print("curla: $curLa");
  print("curlong: $CurLong");
  double distanceInMeters =
      Geolocator.distanceBetween(curLa, CurLong, la, long);
  double distanceInKilometers = distanceInMeters / 1000;
  // print( 'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
  return distanceInKilometers;
}

bool isowner = false;
final uid = FirebaseAuth.instance.currentUser!.uid;

class _postDetailPageState extends State<postDetailPage> {
  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    // double currentLatitude = 0;
    // double currentLongtitude = 0;
    getLocation();
    // print(currentLatitude);
    // print(currentLongtitude);
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;

  Widget build(BuildContext context) {
    // PostModel postModel = PostModel();
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      // print(state.toString());

      if (state is takePostSuccess) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ApplicationPage(),
            ),
          );
        });
        BlocProvider.of<LandingPageBloc>(context).add(TapChange(tabIndex: 1));
      }
      if (state is PostLoading) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (state is postDetailLoaded) {
        getLocation();
        if (state.postModel.uid == uid) {
          isowner = true;
        } else {
          isowner = false;
        }
        double distance = calculateDistances(currentLatitude, currentLongtitude,
            state.postModel.latitude!, state.postModel.longitude!);
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    BlocProvider.of<PostBloc>(context).add(getPostData());
                    Navigator.of(context).pop();
                  },
                ),
                title: Text("Post Detail"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    buildProgress(context, state.postModel.isTake, state.postModel.status),
                    buildPostBoxDetail(
                        context,
                        state.postModel.isTake,
                        state.postModel.status.toString(),
                        state.postModel.pid.toString(),
                        // state.postModel.takeby.toString(),
                        state.postModel.title.toString(),
                        state.postModel.detail.toString(),
                        state.postModel.location_item.toString(),
                        state.postModel.postimage.toString(),
                        state.postModel.postby.toString(),
                        state.postModel.postdate as Timestamp,
                        distance,
                        state.postModel.profileImage.toString(),
                        isowner,
                        state.postModel.priceBuy,
                        state.postModel.pricePay),
                  ],
                ),
              )),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text(state.toString()),
          ),
        );
      }
    });
    // return Scaffold(
    //   body: Center(child: Text("test"),)

    // );
  }
}

Widget buildPostBoxDetail(
    context,
    // String
    bool? isTake,
    String? status,
    String pid,
    String title,
    String detail,
    String location,
    String urlImage,
    String postby,
    Timestamp postdate,
    double distance,
    String userImage,
    bool isowner,
    double? priceBuy,
    double? pricePay) {
    return GestureDetector(
      onTap: () {
        print("tap in post box {$detail}");
      },
      child: Column(
        children: [
          Container(
            // height: 500.h,
            decoration: BoxDecoration(
              color: AppColors.primaryPostBox,
              border: Border.all(
                width: 0.2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userImage),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        postby,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Container(
                    // color: Colors.red,
                    margin: EdgeInsets.all(10),
                    width: 350.w,
                    height: 200.h,
                    child: Image.network(
                      urlImage,
                    )
                    // urlImage != null ?? urlImage.isNotEmpty
                    // ?Image.network(urlImage,fit: BoxFit.cover,)
                    // :Image.asset("assets/images/icon.png")

                    ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                        "${postdate.toDate().day}/${postdate.toDate().month}/${postdate.toDate().year}"),
                  ),
                ),
                Row(
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     margin: EdgeInsets.only(left: 20),
                    //     child: CircleAvatar(
                    //       radius: 30,
                    //       backgroundImage: NetworkImage(userImage),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 10),
                    //   child: Text(
                    //     "Warayut Saisi",
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          child: Image.asset("assets/icons/location.png"),
                        ),
                      ),
                    ),
                    Container(
                      width: 150.w,
                      margin: EdgeInsets.all(5),
                      child: Text(
                        location,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          child: Image.asset("assets/icons/location.png"),
                        ),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.all(10),
                      child: Text(
                        "${distance.toStringAsFixed(1)} km",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          child: Image.asset("assets/icons/coin.png"),
                        ),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.all(10),
                      child: Text(
                        "${priceBuy} ฿",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Align(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          child: Image.asset("assets/icons/coinpay.png"),
                        ),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.all(10),
                      child: Text(
                        "${pricePay} ฿",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Container(
                  // color: Colors.amber,
                  width: 330.w,
                  margin: EdgeInsets.all(20),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                // Divider(
                //   color: Colors.black,
                //   thickness: 0.3,
                // ),
                Divider(
                  thickness: 0.5, // Custom thickness
                  // height:
                  //     20, // Total height of the divider including space above and below it
                  indent: 20, // Starting space (left padding)
                  endIndent: 20, // Ending space (right padding)
                  color: Colors.grey, // Color of the divider
                ),
                // VerticalDivider(
                //   width:
                //       20, // Total width of the divider including space on both sides
                //   thickness: 2, // Thickness of the line
                //   indent: 10, // Top padding
                //   endIndent: 10, // Bottom padding
                //   color: Colors.grey, // Color of the divider
                // ),
                Container(
                  // color: Colors.amber,
                  width: 330.w,
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "wadcxzcjxxjxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                if (isowner == true)
                  buildCommonButton("This is you post", () {}),
                if (isowner == false)
                  buildCommonButton("Send Deal", () {
                    // print("awa");
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // title: Text("Send Deal"),
                            title: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Send Deal"),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ],
                            ),
                            content: Text(
                                "Do you want to send deal to this post?"),
                            actions: [
                              buildCommonButton("Yes", () {
                                BlocProvider.of<PostBloc>(context).add(
                                    takePostEvent(postId: pid, uid: uid));
                              }),
                            ],
                          );
                        });
                  }),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  
 
}
Widget buildProgress (BuildContext context , bool? isTake, String? status) {
  if(isTake == true){
    
    return Container(
      margin: EdgeInsets.all(10),
      child: Text("status is {$status}"),
    );
  }else{
  return Column(
    children: [
      if (isTake == true)
        Container(
          margin: EdgeInsets.all(10),
          child: Text("This post is taken"),
        ),
      if (isTake == false)
        Container(
          margin: EdgeInsets.all(10),
          child: Text("This post is not taken"),
        ),
      if (status == "inprogress")
        Container(
          margin: EdgeInsets.all(10),
          child: Text("This post is in progress"),
        ),
      if (status == "done")
        Container(
          margin: EdgeInsets.all(10),
          child: Text("This post is done"),
        ),
    ],
  );}

}
