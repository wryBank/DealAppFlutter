import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/Profile/bloc/profile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_page.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_event.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../values/color.dart';
import '../common_widgets.dart';
import '../editProfile/bloc/editprofile_event.dart';
import '../editProfile/editprofile_image.dart';
import '../postDetail/postDetail_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context)
        .add(getUserData(uid: FirebaseAuth.instance.currentUser!.uid));

    getLocation();

    BlocProvider.of<PostBloc>(context)
        .add(getPostById(FirebaseAuth.instance.currentUser!.uid));
  }

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
  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ProfileBloc>(context)
            .add(getUserData(uid: FirebaseAuth.instance.currentUser!.uid));
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is getDataState) {
          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.blue,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
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
                ),
              ),
              // bottom: PreferredSize(
              //     preferredSize: const Size.fromHeight(1.0),
              //     child: Container(
              //      // decoration: const BoxDecoration(
              //       //   // color: Colors.white,
              //       //   gradient: LinearGradient(
              //       //     begin: Alignment.topLeft,
              //       //     end: Alignment.bottomRight,
              //       //     colors: [
              //       //       // Color.fromRGBO(207, 162, 250,100),
              //       //       // Color.fromRGBO(194, 233, 251, 100),

              //       //       Color.fromRGBO(224, 195, 252, 100),
              //       //       Color.fromRGBO(142, 197, 252, 100),
              //       //     ],
              //       //   ),
              //       // ),

              //       // color: Colors.grey.withOpacity(0.5),
              //       // color: const Color.fromARGB(255, 0, 128, 255),
              //       height: 0.5,
              //     )),
              // title: Text(
              //   type,
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 16.sp,
              //       fontWeight: FontWeight.normal),
              // ),
              actions: [
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () {
                    print("click edit");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
                    // Navigator.popAndPushNamed(context, "editprofileimage");
                    // MaterialPageRoute(builder: (context) => EditProfileimage());
                  },
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
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
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 0.4,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: size.height * 0.4 - 47,
                          // decoration: BoxDecoration(
                          //   color: Color.fromARGB(255, 88, 172, 255),
                          //   borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(26),
                          //     bottomRight: Radius.circular(26),
                          //   ),
                          // ),
                          decoration: BoxDecoration(
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
                            //   width: 0.0001,
                            //   // color: Colors.black,
                            // ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(26),
                                bottomRight: Radius.circular(26)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 2),
                                    ),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          // state.userModel!.urlprofileimage!),
                                          state.userModel!.urlprofileimage!),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text("${state.userModel!.username}",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.normal)),
                              Text("${state.userModel!.bio}",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                // Container(
                                //     margin: EdgeInsets.symmetric(
                                //       vertical: 1,
                                //     ),
                                //     height: 70.h,
                                //     width: 100.w,
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         borderRadius: BorderRadius.circular(20),
                                //         boxShadow: [
                                //           BoxShadow(
                                //             color: Colors.grey.withOpacity(0.5),
                                //             spreadRadius: 1,
                                //             blurRadius: 7,
                                //             offset: Offset(0,
                                //                 3), // changes position of shadow
                                //           )
                                //         ]),
                                //     child: Stack(
                                //       alignment: Alignment.center,
                                //       children: <Widget>[
                                //         Column(
                                //           children: [
                                //             Text(
                                //               state.userModel!.dealcount
                                //                   .toString(),
                                //               style: TextStyle(
                                //                   fontSize: 20.sp,
                                //                   color: Colors.blue),
                                //             ),
                                //             Expanded(
                                //                 child: Image.asset(
                                //               "assets/icons/onDeal.png",
                                //               fit: BoxFit.cover,
                                //             ))
                                //           ],
                                //         ),
                                //       ],
                                //     )),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 1,
                                    ),
                                    height: 70.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          )
                                        ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text(
                                              state.userModel!.dealcount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Colors.blue),
                                            ),
                                            Expanded(
                                                child: Image.asset(
                                              "assets/icons/onDeal.png",
                                              // "assets/images/onDeal.png",
                                              fit: BoxFit.cover,
                                            ))
                                          ],
                                        ),
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 1,
                                    ),
                                    height: 70.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          )
                                        ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text(
                                              state.userModel!.dealsuccess
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Colors.blue),
                                            ),
                                            Expanded(
                                                child: Image.asset(
                                              "assets/images/icon.png",
                                              fit: BoxFit.cover,
                                            ))
                                          ],
                                        ),
                                      ],
                                    )),
                              ]),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                    if (state is PostLoaded) {
                      return Expanded(
                          child: ListView.builder(
                              // controller: _scrollController,
                              itemCount: state.postModel.length,
                              itemBuilder: (context, index) {
                                // print("post distance: ${posts[index].distance}");
                                final post = state.postModel[index];
                                return buildPostBox(
                                    context,
                                    post.pid ?? "",
                                    post.title!,
                                    post.detail!,
                                    post.location_item ?? "",
                                    post.postimage ?? "",
                                    "a",
                                    post.postdate!,
                                    post.distance!,
                                    post.profileImage ?? "",
                                    post.pricePay!);
                              })
                          // child: FirestoreListView(
                          //     query: state.postModel,
                          //     pageSize: 2,
                          //     itemBuilder: (context, snapshot) {
                          //       final post = snapshot.data();
                          //       double distance = calculateDistances(
                          //           currentLatitude,
                          //           currentLongtitude,
                          //           post.latitude!,
                          //           post.longitude!);
                          //       return buildPostBox(
                          //           post.title!,
                          //           post.detail!,
                          //           post.location_item ??"",
                          //           post.postimage ?? "",
                          //           "a",
                          //           post.postdate!,
                          //           distance,
                          //           post.profileImage ?? "",
                          //           );
                          //     }),
                          );
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          );
        }
        return Container();
      }),
    );

    // add gridview here
  }
}

Widget buildPostBox(
  context,
  String pid,
  String title,
  String detail,
  String location,
  String urlImage,
  String postby,
  Timestamp postdate,
  double distance,
  String userImage,
  double coin,
) {
  return GestureDetector(
    onTap: () {
      print("tap in post box {$pid}");
      BlocProvider.of<PostBloc>(context).add(getPostDetail(pid));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => postDetailPage(comeFrom: 'profile', pid: pid)));
    },
    child: Container(
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
                    backgroundImage: NetworkImage(userImage),
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
              detail,
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
                  "${coin} coin",
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

// Widget buildPostBox(String title, String detail, String location,
//     String urlImage, String postby, Timestamp postdate, double distance) {
//   return GestureDetector(
//     onTap: () {
//       print("tap in post box {$detail}");
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         color: AppColors.primaryPostBox,
//         border: Border.all(
//           width: 0.2,
//           color: Colors.black,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       margin: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Container(
//               // color: Colors.red,
//               margin: EdgeInsets.all(10),
//               width: 235.w,
//               height: 120.h,
//               child: Image.network(urlImage)
//               // urlImage != null ?? urlImage.isNotEmpty
//               // ?Image.network(urlImage,fit: BoxFit.cover,)
//               // :Image.asset("assets/images/icon.png")

//               ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               margin: EdgeInsets.only(right: 10),
//               child: Text(
//                   "${postdate.toDate().day}/${postdate.toDate().month}/${postdate.toDate().year}"),
//             ),
//           ),
//           Row(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   margin: EdgeInsets.only(left: 20),
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: AssetImage("assets/images/icon.png"),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 10),
//                 child: Text(
//                   "Warayut Saisi",
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             // color: Colors.amber,
//             width: 330.w,
//             margin: EdgeInsets.all(20),
//             child: Text(
//               "asaaaaaaaaaaaaaaaaaaaaaaaaa",
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           Row(
//             children: [
//               Align(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 20),
//                   child: Container(
//                     width: 20.w,
//                     height: 20.h,
//                     child: Image.asset("assets/icons/location.png"),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 150.w,
//                 margin: EdgeInsets.all(5),
//                 child: Text(
//                   detail,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               Align(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 20),
//                   child: Container(
//                     width: 20.w,
//                     height: 20.h,
//                     child: Image.asset("assets/icons/location.png"),
//                   ),
//                 ),
//               ),
//               Container(
//                 // margin: EdgeInsets.all(10),
//                 child: Text(
//                   "${distance.toStringAsFixed(1)} km",
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// calculateDistances(double curLa, double CurLong, double la, double long) {
//   print("curla: $curLa");
//   print("curlong: $CurLong");
//   double distanceInMeters =
//       Geolocator.distanceBetween(curLa, CurLong, la, long);
//   double distanceInKilometers = distanceInMeters / 1000;
//   print(
//       'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
//       return distanceInKilometers;
// }
