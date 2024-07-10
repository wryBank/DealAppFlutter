import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/common_widgets.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';

import '../../model/postmodel.dart';
import '../../values/color.dart';
import '../post/bloc/post_bloc.dart';
import '../post/bloc/post_event.dart';
import '../postDetail/postDetail_page.dart';
import 'filterPostDeal.dart';

class DealPage extends StatefulWidget {
  const DealPage({super.key});

  @override
  State<DealPage> createState() => _DealPageState();
}

final uid = FirebaseAuth.instance.currentUser!.uid;

class _DealPageState extends State<DealPage> {
  void _openFilterPostDeal() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(height: 250, child: filterPosts()));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(getOwnDeal(uid: uid));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool bt1Click = false;
    bool bt2Click = false;
    bool bt3Click = false;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
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
          actions: [
            IconButton(
              onPressed: () {
                _openFilterPostDeal();
              },
              icon: Icon(
                Icons.filter_list,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            bool bt1Click = false;
            bool bt2Click = false;
            BlocProvider.of<PostBloc>(context).add(getOwnDeal(uid: uid));
          },
          child: Column(children: [
            // AppBar(
            //   // backgroundColor: AppColors.primaryAppbar,
            //   automaticallyImplyLeading: false,
            //   flexibleSpace: Container(
            //     decoration: BoxDecoration(
            //       // color: Colors.white,
            //       gradient: LinearGradient(
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //         colors: [
            //           // Color.fromRGBO(207, 162, 250,100),
            //           // Color.fromRGBO(194, 233, 251, 100),
            //           Color.fromARGB(255, 207, 162,
            //               250), // Corrected method and opacity value
            //           Color.fromARGB(255, 194, 233,
            //               251), // Corrected method and opacity value
            //           // Colors.white,
            //         ],
            //       ),
            //       // border: Border.all(
            //       //   width: 0.2,
            //       //   color: Colors.black,
            //       // ),
            //       // borderRadius: BorderRadius.circular(25),
            //     ),
            //   ),
            //   actions: [
            //     IconButton(
            //       onPressed: () {
            //         _openFilterPostDeal();
            //       },
            //       icon: Icon(
            //         Icons.filter_list,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            //   // child: Row(
            //   //   mainAxisAlignment: MainAxisAlignment.end,
            //   //   children: [
            //   //     Column(
            //   //       children: [
            //   //         IconButton(
            //   //           onPressed: () {
            //   //             _openFilterPostDeal();
            //   //           },
            //   //           icon: Icon(
            //   //             Icons.filter_list,
            //   //             color: Colors.white,
            //   //           ),
            //   //         ),
            //   //       ],
            //   //     ),
            //   //   ],
            //   // ),
            // ),
            // Stack(
            //   children: <Widget>[
            //     Container(
            //       // height: size.height * 0.3 - 47,
            //       height: 130,
            //       // color: AppColors.primaryAppbar,
            //       decoration: BoxDecoration(
            //         color: AppColors.primaryAppbar,
            //         // borderRadius: BorderRadius.only(
            //         //   bottomLeft: Radius.circular(26),
            //         //   bottomRight: Radius.circular(26),
            //         // ),
            //       ),
            //     ),
            //     Center(
            //       child: Container(
            //         margin: EdgeInsets.only(top: 50),
            //         child: Text(
            //           "Deal",
            //           style: TextStyle(
            //               fontSize: 30.sp,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //     height: 50,
            //     // color: AppColors.primaryAppbar,
            //     decoration: BoxDecoration(
            //       color: AppColors.primaryAppbar,
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(26),
            //         bottomRight: Radius.circular(26),
            //       ),
            //     ),
            //     child: buildCommonButton3(
            //         context, "กำลังดำเนินการ", "สำเร็จแล้ว", "test3", uid)),
            // Container(
            //   // child: buildSelectBox(context),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              print("state in feed is $state");
              if (state is PostListLoaded) {
                List<PostModel> postModel = state.postModel;
                print("postModel: $postModel");
                return Expanded(
                    child: Container(
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
                  // color: AppColors.primaryPostBox,
                  child: ListView.builder(
                      // controller: _scrollController,
                      itemCount: postModel.length,
                      itemBuilder: (context, index) {
                        // print("post distance: ${posts[index].distance}");
                        final post = postModel[index];
                        return buildPostBox(
                          context,
                          post.pid ?? "",
                          post.title!,
                          post.detail!,
                          post.location_item ?? "",
                          post.postimage ?? "",
                          "a",
                          post.postdate!,
                          post.distance ?? 0.0,
                          post.profileImage ?? "",
                          post.pricePay!,
                        );
                      }),
                ));
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            })
          ]),
        ),
        backgroundColor: AppColors.primaryPostBox);
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
      // BlocProvider.of<PostBloc>(context).add(getPostDetail(pid));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => postDetailPage(comeFrom: 'ownDeal', pid: pid)));
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

bool bt1Click = false;
bool bt2Click = false;
buildCommonButton3(
  context,
  String buttonName1,
  String buttonName2,
  String buttonName3,
  String uid,
) {
  // bool bt1Click = false;
  // bool bt2Click = false;
  bool bt3Click = false;
  return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            bt1Click = !bt1Click;
            bt2Click = false;
            bt3Click = false;
            // BlocProvider.of<PostBloc>(context).add(getPostByType(true));
            BlocProvider.of<PostBloc>(context).add(getOwnDeal(uid: uid));
            // if(bt1Click == false && bt2Click == false){
            //   BlocProvider.of<PostBloc>(context).add(getOwnDeal(uid: uid));
            // }
          },
          child: Center(
            child: Container(
              width: 130.w,
              height: 30.h,
              // margin: EdgeInsets.only(left: 150.w,right: 25.w,),
              decoration: BoxDecoration(
                  color: bt1Click ? AppColors.primaryAppbar : Colors.white,
                  borderRadius: BorderRadius.circular(30.w),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                        color: Colors.grey.withOpacity(0.5))
                  ]),
              child: Center(
                  child: Text(
                buttonName1,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              )),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            bt1Click = false;
            bt2Click = !bt2Click;
            print("bt2Click: $bt2Click");
            print("bt1Click: $bt1Click");
            // BlocProvider.of<PostBloc>(context).add(getPostByType(false));
            if (bt1Click == false && bt2Click == false) {
              BlocProvider.of<PostBloc>(context).add(getOwnDeal(uid: uid));
            } else {
              BlocProvider.of<PostBloc>(context).add(getOwnDealDone(uid: uid));
            }
          },
          child: Center(
            child: Container(
              width: 130.w,
              height: 30.h,
              // margin: EdgeInsets.only(left: 150.w,right: 25.w,),
              decoration: BoxDecoration(
                  color: bt2Click ? AppColors.primaryAppbar : Colors.white,
                  borderRadius: BorderRadius.circular(30.w),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                        color: Colors.grey.withOpacity(0.5))
                  ]),
              child: Center(
                  child: Text(
                buttonName2,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              )),
            ),
          ),
        ),
      ],
    );
  });
}

bool FindJobClick = false;
bool HireJobClick = false;
buildSelectBox(BuildContext context) {
  return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
    print("11111111 FindJobClick: $FindJobClick HireJobClick: $HireJobClick");
    // if (state is selectBoxSuccess) {
    //   print(state.isFindJob);
    // }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // BlocProvider.of<PostBloc>(context)
            //     .add(selectBoxPostType(true));
            // BlocProvider.of<PostBloc>(context).add(getPostByType(true));
            if (FindJobClick == false) {
              FindJobClick = true;
            } else {
              FindJobClick = false;
            }
            if (FindJobClick && HireJobClick ||
                !FindJobClick && !HireJobClick) {
              BlocProvider.of<PostBloc>(context).add(getPostData());
            }
            print("FindJobClick: $FindJobClick HireJobClick: $HireJobClick");
          },
          child: Center(
            child: Container(
              width: 80.w,
              height: 30.h,
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: FindJobClick ? Colors.white : AppColors.primaryAppbar,
                  // border: Border.all(color: Colors.grey),
                  // border: FindJobClick
                  //     ? Border.all(
                  //         color: AppColors.primaryAppbar,
                  //         width: 1.0,
                  //       )
                  //     : Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                        color: Colors.grey.withOpacity(0.5))
                  ]
                  // border: FindJobClick ? Border.all( color: AppColors.primaryAppbar,
                  // width: 1.0,
                  //       )
                  //     : Border.all(color: Colors.white , width: 1.0),
                  // borderRadius: BorderRadius.circular(50),
                  // borderRadius: BorderRadius.circular(50),
                  ),
              child: Center(
                child: Text(
                  'รับจ้าง',
                  style: TextStyle(
                    color: FindJobClick
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            // BlocProvider.of<PostBloc>(context)
            //     .add(selectBoxPostType(false));

            // BlocProvider.of<PostBloc>(context).add(getPostByType(false));
            if (HireJobClick == true) {
              HireJobClick = false;
            } else {
              HireJobClick = true;
            }
            if (FindJobClick && HireJobClick ||
                !FindJobClick && !HireJobClick) {
              BlocProvider.of<PostBloc>(context).add(getPostData());
            }
            print("HireJobClick: $HireJobClick");
          },
          child: Center(
            child: Container(
              width: 80.w,
              height: 30.h,
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: HireJobClick ? Colors.white : AppColors.primaryAppbar,
                  // color: AppColors.primaryAppbar,
                  // border: HireJobClick
                  //     ? Border.all(
                  //         color: AppColors.primaryAppbar,
                  //         width: 1.0,
                  //       )
                  //     : Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                        color: Colors.grey.withOpacity(0.5))
                  ]
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.white,
                  //     spreadRadius: 3,
                  //     blurRadius: 1,
                  //     offset: Offset(0, 1), // changes position of shadow
                  //   )
                  // ]
                  ),
              child: Center(
                child: Text(
                  'จ้างงาน',
                  style: TextStyle(
                    // color: HireJobClick ? Colors.white : Colors.black,

                    color: HireJobClick
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white,
                    // : Color.fromARGB(255, 207, 207, 207),
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  });
}
