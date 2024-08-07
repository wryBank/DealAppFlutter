import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/firebase/PushNotificationService.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/pages/Deal/deal_page.dart';
import 'package:flutterdealapp/pages/Profile/otherProfile.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/UserBloc/user_repo.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/application/bloc/appBloc.dart';
import 'package:flutterdealapp/pages/application/bloc/appEvent.dart';
import 'package:flutterdealapp/pages/chat/chat_page.dart';
import 'package:flutterdealapp/pages/common_widgets.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_event.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
import 'package:flutterdealapp/pages/post/post_provider.dart';
import 'package:flutterdealapp/pages/postDetail/bloc/postDetail.state.dart';
import 'package:flutterdealapp/pages/postDetail/bloc/postDetail_bloc.dart';
import 'package:flutterdealapp/pages/postDetail/bloc/postDetail_event.dart';
import 'package:flutterdealapp/pages/postDetail/timeline.dart';
import 'package:geolocator/geolocator.dart';
import 'package:googleapis/blogger/v3.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../values/color.dart';

class postDetailPage extends StatefulWidget {
  String? comeFrom;
  String? pid;
  postDetailPage({
    super.key,
    this.comeFrom,
    this.pid,
  });

  @override
  State<postDetailPage> createState() => _postDetailPageState();
}

PostProvider postProvider = PostProvider();
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
    if (widget.pid != null) {
      print("pid: ${widget.pid}");
      BlocProvider.of<PostBloc>(context).add(getPostDetail(widget.pid!));
    }

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
            BlocProvider.of<PostBloc>(context)
                .add(getPostDetail(state.postModel.pid.toString()));
          },
          child: Scaffold(
              appBar: AppBar(
                // automaticallyImplyLeading: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        // Color.fromRGBO(207, 162, 250,100),
                        // Color.fromRGBO(194, 233, 251, 100),

                        Color.fromRGBO(224, 195, 252, 100),
                        Color.fromRGBO(142, 197, 252, 100),
                      ],
                    ),
                    // border: Border.all(
                    //   width: 0.2,
                    //   color: Colors.black,
                    // ),
                    // borderRadius: BorderRadius.circular(25),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (widget.comeFrom == 'ownDeal') {
                      BlocProvider.of<PostBloc>(context).add(getOwnDeal(
                          uid: FirebaseAuth.instance.currentUser!.uid));
                    }
                    if (widget.comeFrom == 'profile') {
                      BlocProvider.of<PostBloc>(context).add(
                          getPostById(FirebaseAuth.instance.currentUser!.uid));
                    } else {
                      BlocProvider.of<PostBloc>(context).add(getPostData());
                    }
                    Navigator.of(context).pop();
                  },
                ),
                title: Text("Post Detail"),
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      // Color.fromRGBO(161, 196, 253, 100),
                      // Color.fromRGBO(194, 233, 251, 100),
                      Color.fromRGBO(224, 195, 252, 100),
                      Color.fromRGBO(142, 197, 252, 100),
                      // Colors.white,
                    ],
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildProgress(
                            context,
                            state.postModel.pid.toString(),
                            state.postModel.uid.toString(),
                            state.postModel.title.toString(),
                            state.postModel.isFindJob!,
                            state.postModel.takeby.toString(),
                            state.postModel.isTake,
                            state.postModel.status,
                            state.postModel.isGave,
                            state.postModel.isReceived),
                        if (state.postModel.isTake == true)
                          whoTakePost(
                              state.postModel.pid!,
                              state.postModel.takeby!,
                              state.postModel.profileImage!),
                        buildPostBoxDetail(
                            context,
                            state.postModel.uid.toString(),
                            state.postModel.takeby.toString(),
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
                            state.postModel.pricePay,
                            state.postModel.isGave,
                            state.postModel.isReceived),
                      ],
                    ),
                  ),
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

Widget whoTakePost(
  String pid,
  String takeby,
  String urlImage,
) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(takeby)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData && snapshot.data!.data() != null) {}
        return Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherProfilePage(
                                    userid: takeby,
                                    beforePostid: pid,
                                  )));
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        snapshot.data!.data()!['urlprofileimage'],
                      ),
                    ),
                  ),
                  // Text("ewsweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"),
                  Text(snapshot.data!.data()!['username'].length > 10
                      ? '${snapshot.data!.data()!['username'].substring(0, 10)}...'
                      : snapshot.data!.data()!['username']),
                ],
              ),
              Container(
                width: 150.w,
                height: 20.h,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  border: Border.all(
                    width: 0.1,
                    // color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("ฉันรับข้อเสนอนี้!"),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Widget buildPostBoxDetail(
    context,
    // String
    String uid,
    String takeby,
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
    double? pricePay,
    bool? isGave,
    bool? isReceived) {
  return GestureDetector(
    onTap: () {
      print("tap in post box {$detail}");
    },
    child: Column(
      children: [
        Container(
          // height: 500.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            border: Border.all(
              width: 0.1,
              // color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtherProfilePage(
                                      userid: uid,
                                      beforePostid: pid,
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userImage),
                        ),
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
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        child: Image.asset(
                          "assets/icons/location.png",
                        ),
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
                  detail,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              if (isTake == true)
                SizedBox(
                  height: 50.h,
                  width: 150.w,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.chat, size: 30),
                    label: Text("Chat", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(83, 82, 125, 0.8),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      String receiverUsername = " ";
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(takeby)
                          .get()
                          .then((value) {
                        print("value: ${value.data()}");
                         receiverUsername = value.data()!['username'];
                      });
                      if (isowner == true) {
                        print("pid: $pid");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                    receiverUserId: takeby,
                                    receiverUsername: receiverUsername,
                                    pid: pid.toString())));
                      } else if (isowner == false) {
                        print("pid: $pid");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      receiverUserId: uid,
                                      receiverUsername: postby,
                                      pid: pid.toString(),
                                    )));
                      }
                    },
                    // child: Text("chat"),
                  ),
                ),

              // if (isowner == true) buildCommonButton("This is you post", () {}),
              if (isowner == false && isTake == false)
                buildCommonButton("Send Deal", () {
                  // print("awa");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          // title: Text("Send Deal"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          content:
                              Text("Do you want to send deal to this post?"),
                          actions: [
                            buildCommonButton("Yes", () {
                              BlocProvider.of<PostBloc>(context).add(
                                  takePostEvent(
                                      postId: pid,
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      uidPostby: uid));
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

Widget buildProgress(
    BuildContext context,
    String pid,
    String uid,
    String title,
    bool isFindJob,
    String takeby,
    bool? isTake,
    String? status,
    bool? isGave,
    bool? isReceived) {
  if (isTake == true) {
    print("takeby: $takeby  ");
    print("isFindJob = $isFindJob");
    print("pid: $pid");
    // if is Findjob = true
    print("status: $status");
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("posts")
                .doc(pid)
                .snapshots(),
            builder: (context, snapshot) {
              print("snapshot: ${snapshot.data}");
              if (snapshot.hasData && snapshot.data!.exists) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                status = data['status'] as String?;
                return SizedBox(
                  height: 100,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Row(
                        // scrollDirection: Axis.horizontal,
                        // padding: EdgeInsets.all(10),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 120,
                            child: timelineDeal(
                              // isProgress: status == "inprogress" ? true : false,
                              isProgress: true,
                              // isCompleted: status == "inprogress" ? false : true,
                              isCompleted: false,
                              isPast: true,
                              eventCard: Text("inProgress",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: timelineDeal(
                              isProgress: false,
                              // isCompleted: status == "done" ? true : false,
                              isCompleted: false,
                              // isPast:false,
                              isPast: status == "inprogress" || status == "done"
                                  ? true
                                  : false,
                              eventCard: const Text("Delivering",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: timelineDeal(
                              // isProgress: status == "inprogress" ? true : false,
                              // isCompleted: status == "done" ? true : false,
                              isProgress: false,
                              isCompleted: true,
                              isPast: status == "done" ? true : false,
                              // isPast: status == "done" ? true : false,
                              eventCard: const Text("Complete",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
        // Text(
        //     "This post is not given yet have u Give an items yet ? ")),
        if (uid == FirebaseAuth.instance.currentUser!.uid &&
            isReceived == false &&
            status == "inprogress")
          Column(
            children: [
              BlocBuilder<postDetailBloc, postDetailState>(
                  builder: (context, state) {
                if (state is clickPostState && isReceived == true) {
                  // print("instate isClickReceived ${state.isClickReceived}");
                  // status = state.isClickReceived == true ? "done" : "inprogress";
                  return Container(
                    child: Text(
                      "รับของเรียบร้อย",
                      style: TextStyle(color: Colors.green),
                    ),
                  );
                } else {
                  return Container(
                    child: SizedBox(
                      width: 150.w,
                      height: 35.h,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.check, size: 30),
                        label: Text("รับของเรียบร้อย"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(83, 82, 125, 0.8),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          isReceived = true;
                          // postProvider.updateStatusReceived(pid, isReceived!,uid,isFindJob);
                          BlocProvider.of<postDetailBloc>(context).add(
                              clickButton(
                                  postId: pid,
                                  isReceived: isReceived!,
                                  uidPostby: uid,
                                  isFindJob: isFindJob));

                          user_provider userProvider = user_provider();

                          PushNotificationService.sendClickNotificationToUser(
                              await userProvider.getToken(takeby),
                              pid,
                              title,
                              "อีกฝ่ายได้กดยืนยันแล้ว!");
                          print(
                              "token = ${userProvider.getToken(uid).toString()}");

                          // context.read<postDetailBloc>().add(
                          //   clickButton(
                          //     postId: pid,
                          //     isReceived: isReceived!,
                          //     uidPostby: uid,
                          //     isFindJob: isFindJob
                          //   )
                          // );
                          // BlocProvider.of<PostBloc>(context).add(updateStatusReceived(pid, isReceived!));
                          // isReceived = true;
                          // status = "inprogress";
                        },
                      ),
                    ),
                  );
                }
              })
            ],
          ),

        // if (uid == FirebaseAuth.instance.currentUser!.uid &&
        //     isReceived == true &&
        //     status == "inprogress")
        if (takeby == FirebaseAuth.instance.currentUser!.uid &&
            isGave == false &&
            status == "inprogress")
          BlocBuilder<postDetailBloc, postDetailState>(
              builder: (context, state) {
            print("state = $state");
            if (state is clickPostState2 && isGave == true) {
              // print("instate isClickReceived ${state.isGrave}");
              // status = state.isGraveClicked == true ? "done" : "inprogress";
              return Container(
                child: Text(
                  "รับของเรียบร้อย",
                  style: TextStyle(color: Colors.green),
                ),
              );
            } else {
              return Column(
                children: [
                  Container(
                    child: SizedBox(
                      height: 35.h,
                      width: 150.w,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.check, size: 30),
                        label: Text("รับของเรียบร้อย"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(83, 82, 125, 0.8),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // child: Text("ร2ับของเรียบร้อย23  "),
                        onPressed: () async {
                          if (isGave == false) {
                            isGave = true;
                            print("isGave: $isGave");
                            print("pid: $pid  ");
                            // postProvider.updateStatusGave(
                            //     pid, isGave!, takeby, isFindJob);
                            BlocProvider.of<postDetailBloc>(context).add(
                                clickButton2(
                                    postId: pid,
                                    isGave: isGave!,
                                    uidtakeby: takeby,
                                    isFindJob: isFindJob));
                            user_provider userProvider = user_provider();
                            print(
                                "token = ${userProvider.getToken(uid).toString()}");

                            PushNotificationService.sendClickNotificationToUser(
                                await userProvider.getToken(uid),
                                pid,
                                title,
                                "อีกฝ่ายได้กดยืนยันแล้ว!");
                            // context.read<postDetailBloc>().add(
                            //   clickButton(
                            //     postId: pid,
                            //     isReceived: isReceived!,
                            //     uidPostby: uid,
                            //     isFindJob: isFindJob
                            //   )
                            // );
                            // isGave = true;
                            // status = "done" ;
                          }
                        },
                      ),
                    ),
                  )
                ],
              );
            }
          }),
        // if (takeby == FirebaseAuth.instance.currentUser!.uid &&
        //     isGave == false &&
        //     status == "inprogress")
        //   Column(
        //     children: [
        //       Container(
        //         child: ElevatedButton(
        //           child: Text("รับของเรียบร้อย23"),
        //           onPressed: () {
        //             if (isGave == false) {
        //               isGave = true;
        //               print("isGave: $isGave");
        //               print("pid: $pid  ");
        //               postProvider.updateStatusGave(pid, isGave!,takeby,isFindJob);
        //               // BlocProvider.of<PostBloc>(context).add(updateStatusGave(pid, isGave!));
        //               // isGave = true;
        //               // status = "done" ;
        //             }
        //           },
        //         ),
        //       )
        //     ],
        //   ),
        if (takeby == FirebaseAuth.instance.currentUser!.uid &&
            isGave == true &&
            status == "inprogress")
          Column(
            children: [
              Container(
                child: Text("กำลังรอให้อีกฝ่ายยืนยัน"),
              )
            ],
          ),
      ],
    );
  } else {
    return SizedBox();
  }
  // else {
  //   return Column(
  //     children: [
  //       if (isTake == true)
  //         Container(
  //           margin: EdgeInsets.all(10),
  //           child: Text("This post is taken"),
  //         ),
  //       if (isTake == false)
  //         Container(
  //           margin: EdgeInsets.all(10),
  //           child: Text("This post is not taken"),
  //         ),
  //       if (status == "inprogress")
  //         Container(
  //           margin: EdgeInsets.all(10),
  //           child: Text("This post is in progress"),
  //         ),
  //       if (status == "done")
  //         Container(
  //           margin: EdgeInsets.all(10),
  //           child: Text("This post is done"),
  //         ),
  //     ],
  //   );
  // }
}
