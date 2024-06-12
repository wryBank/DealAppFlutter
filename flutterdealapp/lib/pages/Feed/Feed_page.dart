import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/postmodel.dart';
import '../../values/color.dart';
import '../post/bloc/post_event.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Future<void> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position);
    currentLatitude = position.latitude;
    currentLongtitude = position.longitude;
  }

  double currentLatitude = 0;
  double currentLongtitude = 0;
  final queryPost = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<PostModel>(
        fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  @override
  void initState() {
    super.initState();
    getLocation();
    BlocProvider.of<PostBloc>(context).add(getPostData());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryAppbar,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              // color: AppColors.primaryAppbar,
              height: 0.5,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getLocation();
            BlocProvider.of<PostBloc>(context).add(getPostData());
          },
          child: Column(children: <Widget>[
            Stack(children: [
              Container(
                height: size.height * 0.2 - 47,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 88, 172, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    bottomRight: Radius.circular(26),
                  ),
                ),
              ),
            ]),
            BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is PostLoaded) {
                return Expanded(
                  child: FirestoreListView(
                      query: state.postModel,
                      pageSize: 2,
                      itemBuilder: (context, snapshot) {
                        final post = snapshot.data();
                        double distance = calculateDistances(currentLatitude,
                            currentLongtitude, post.latitude!, post.longitude!);
                        return buildPostBox(
                            post.title!,
                            post.detail!,
                            "",
                            post.postimage ?? "",
                            "a",
                            post.postdate!,
                            distance);
                      }),
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            })
          ]),
        ));
  }
}

Widget buildPostBox(String title, String detail, String location,
    String urlImage, String postby, Timestamp postdate, double distance) {
  return GestureDetector(
    onTap: () {
      print("tap in post box {$detail}");
    },
    child: Container(
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
          Container(
              // color: Colors.red,
              margin: EdgeInsets.all(10),
              width: 235.w,
              height: 120.h,
              child: Image.network(urlImage)
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
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/icon.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "Warayut Saisi",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.amber,
            width: 330.w,
            margin: EdgeInsets.all(20),
            child: Text(
              "asaaaaaaaaaaaaaaaaaaaaaaaaa",
              style: TextStyle(fontSize: 20),
            ),
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
                  detail,
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
        ],
      ),
    ),
  );
}

calculateDistances(double curLa, double CurLong, double la, double long) {
  print("curla: $curLa");
  print("curlong: $CurLong");
  double distanceInMeters =
      Geolocator.distanceBetween(curLa, CurLong, la, long);
  double distanceInKilometers = distanceInMeters / 1000;
  print(
      'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
  return distanceInKilometers;
}
