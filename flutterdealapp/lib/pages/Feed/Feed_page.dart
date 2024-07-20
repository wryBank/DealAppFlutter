import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/UserBloc/bloc/user_bloc.dart';
import 'package:flutterdealapp/pages/createpost/bloc/createPost_bloc.dart';
import 'package:flutterdealapp/pages/createpost/bloc/createPost_state.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
import 'package:flutterdealapp/service/shared_preferences_service.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../CustomFABLocation.dart';
import '../../model/postmodel.dart';
import '../../values/color.dart';
import '../Deal/filterPostDeal.dart';
import '../Profile/bloc/profile_bloc.dart';
import '../UserBloc/user_provider.dart';
import '../createpost/createPost_page.dart';
import '../post/bloc/post_event.dart';
import '../postDetail/postDetail_page.dart';

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
    await user_provider().updateLocation(position.latitude, position.longitude);
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;
  double currentLatitude = 0;
  double currentLongtitude = 0;
  // final queryPost = FirebaseFirestore.instance
  //     .collection('posts')
  //     .withConverter<PostModel>(
  //       fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
  //       toFirestore: (user, _) => user.toJson(),
  //     );
  // List<PostModel> postsList = [];
  Future<List<PostModel>> getAndSortPosts() async {
    // final querySanpshot = await postModel.get();
    // final posts = querySanpshot.docs.map((doc) => doc.data()).toList();
    final posts = FirebaseFirestore.instance.collection('posts').get();

    final querySnapshot = await posts;
    // .where('isTake', isEqualTo: false)
    // .orderBy('detail')
    // .withConverter<PostModel>(
    //   fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
    //   toFirestore: (post, _) => post.toJson(),
    // );
    List<PostModel> postsList = querySnapshot.docs
        .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    postsList.forEach((element) async {
      element.distance = calculateDistances(currentLatitude, currentLongtitude,
          element.latitude!, element.longitude!);
    });
    postsList.sort((a, b) => a.distance!.compareTo(b.distance!));

    // postsList = posts;
    // final queryPost = FirebaseFirestore.instance
    //     .collection('posts')
    //     .where('isTake', isEqualTo: false)
    //     .orderBy('distance')
    //     .withConverter<PostModel>(
    //       fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
    //       toFirestore: (post, _) => post.toJson(),
    //     );
    print("posts length: ${postsList.length}");
    return postsList;
  }

  // Future<Query<PostModel>> getAndSortPosts() async {
  //   final query = FirebaseFirestore.instance
  //       .collection('posts')
  //       .where('isTake', isEqualTo: false) // Add your filter here

  //       .withConverter<PostModel>(
  //         fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
  //         toFirestore: (post, _) => post.toJson(),
  //       );
  //   return query;
  // }

  // List? postList;

  // final ScrollController _scrollController = ScrollController();
  // bool isLoading = false;
  // bool hasMore = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context)
        .add(getUserData(uid: FirebaseAuth.instance.currentUser!.uid));
    // _scrollController.addListener((){
    //   if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
    //     maxpage++;
    //   getAndSortPosts();

    //   }
    // });

    // double currentLatitude = 0;
    // double currentLongtitude = 0;
    getLocation();

    // UserModel userModel =
    BlocProvider.of<PostBloc>(context).add(getPostData());
  }

  // void _scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     _fetchMorePost();
  //     // BlocProvider.of<PostBloc>(context).add(getPostData());
  //   }
  // }

  // void _fetchMorePost() {
  //   if (isLoading || !hasMore) return;

  //   setState(() {
  //     isLoading = true;
  //   });
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  ShardPreferencesService shardPreferencesService = ShardPreferencesService();

  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    // shardPreferencesService.readCache(key: "email");
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: AppColors.primaryAppbar,
        //   bottom: PreferredSize(
        //     preferredSize: const Size.fromHeight(1.0),
        //     child: Container(
        //       // color: AppColors.primaryAppbar,
        //       height: 0.5,
        //     ),
        //   ),
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //     Image.asset(
        //       "assets/icons/coin.png",
        //       width: 50.w,
        //       height: 50.h,
        //     ),
        //   ]),
        // ),
        body: RefreshIndicator(
          onRefresh: () async {
            getLocation();
            BlocProvider.of<PostBloc>(context).add(getPostData());
            // setState(() {
            // });
            HireJobClick = false;
            FindJobClick = false;
          },
          child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is getDataState) {
              userModel = state.userModel!;
              double coin = state.userModel!.coin!;
              return Container(
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
                child: Column(
                  children: [
                    AppBar(
                      // backgroundColor: Colors.red,
                      automaticallyImplyLeading: false,
                      // title:
                      flexibleSpace: Container(
                        color: Color.fromRGBO(224, 195, 252, 100),
                        // color: Colors.transparent,
                        height: 60.h,
                        // decoration: const BoxDecoration(
                        //   // color: Colors.white,
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [
                        //       // Color.fromRGBO(207, 162, 250,100),
                        //       // Color.fromRGBO(194, 233, 251, 100),

                        //       Color.fromRGBO(224, 195, 252, 100),
                        //       Color.fromRGBO(142, 197, 252, 100),
                        //     ],
                        //   ),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text(
                                  "  Discovery Deals",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                )),
                                Container(
                                  child: Text(
                                    state.userModel!.username ?? "",
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   child: Text(
                            //     state.userModel!.username ?? "",
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/coin.png",
                                    width: 25.w,
                                    height: 25.h,
                                  ),
                                  Text(state.userModel!.coin.toString(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black54,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // return AppBar(
                    //   backgroundColor: AppColors.primaryAppbar,
                    //   automaticallyImplyLeading: false,
                    //   title: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Column(
                    //         children: [
                    //           Image.asset(
                    //             "assets/icons/coin.png",
                    //             width: 25.w,
                    //             height: 25.h,
                    //           ),
                    //           BlocBuilder<UserBloc, UserState>(
                    //               builder: (context, state) {
                    //             if (state is getUserByUidState) {
                    //               return Text(state.userModel.coin.toString(),
                    //                   style: TextStyle(
                    //                     fontSize: 15.sp,
                    //                     color: Colors.white,
                    //                   ));
                    //             } else {
                    //               return Text("100",
                    //                   style: TextStyle(
                    //                     fontSize: 15.sp,
                    //                     color: Colors.white,
                    //                   ));
                    //             }
                    //           })
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // );
                    // Container(
                    //   height: 50,
                    //   // color: AppColors.primaryAppbar,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.primaryAppbar,
                    //     borderRadius: BorderRadius.only(
                    //       bottomLeft: Radius.circular(26),
                    //       bottomRight: Radius.circular(26),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   child: Container(
                    //     height: 15.h,
                    //     decoration: const BoxDecoration(
                    //       // color: Colors.white,
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //         colors: [
                    //           // Color.fromRGBO(207, 162, 250,100),
                    //           // Color.fromRGBO(194, 233, 251, 100),
                    //           Color.fromRGBO(224, 195, 252, 100),
                    //           Color.fromRGBO(142, 197, 252, 100),
                    //           // Color.fromRGBO(224, 195, 252, 100),
                    //           // Color.fromRGBO(142, 197, 252, 100),
                    //           // Color.fromRGBO(224, 195, 252, 100),
                    //           // Color.fromRGBO(142, 197, 252, 100),
                    //         ],
                    //       ),
                    //       // border: Border.all(
                    //       //   width: 0.2,
                    //       //   color: Colors.black,
                    //       // ),
                    //       // borderRadius: BorderRadius.circular(25),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 0.6,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 60), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50.h,
                          child: buildSelectBox(context),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                      if (state is PostListLoaded) {
                        return Expanded(
                            // child: FirestoreListView<List<PostModel>>(
                            //     query: state.postModel,
                            //     pageSize: 2,
                            //     itemBuilder: (context, snapshot) {
                            //       final post = snapshot.data();

                            //       // posts
                            //       //     .sort((a, b) => a.distance!.compareTo(b.distance!));

                            //       final distance = calculateDistances(
                            //           currentLatitude,
                            //           currentLongtitude,
                            //           post.latitude!,
                            //           post.longitude!);
                            //       // post.distance = calculateDistances(currentLatitude,
                            //       //     currentLongtitude, post.latitude!, post.longitude!);

                            //       //sort post.distance

                            //       // getAndSortPosts(state.postModel);

                            //       // if (distance < 6) {
                            //       return buildPostBox(
                            //           context,
                            //           post.pid ?? "",
                            //           post.title!,
                            //           post.detail!,
                            //           post.location_item ?? "",
                            //           post.postimage ?? "",
                            //           "a",
                            //           post.postdate!,
                            //           distance ,
                            //           post.profileImage ?? "");
                            //       // } else {
                            //       //   return Container();
                            //       // }
                            //     }),

                            // child: FutureBuilder(
                            // future: state.postModel,
                            // builder: (context, snapshot) {
                            // if (snapshot.connectionState == ConnectionState.done &&
                            //     snapshot.hasData) {
                            // final posts = snapshot.data!;
                            child: ListView.builder(
                                // controller: _scrollController,
                                itemCount: state.postModel.length,
                                itemBuilder: (context, index) {
                                  // print("post distance: ${posts[index].distance}");
                                  if (state.postModel[index].uid! != uid) {
                                    final post = state.postModel[index];
                                    return buildPostBox(
                                        context,
                                        post.pid ?? "",
                                        post.title!,
                                        post.detail!,
                                        post.location_item ?? "",
                                        post.postimage ?? "",
                                        post.postby!,
                                        post.postdate!,
                                        post.distance!,
                                        post.profileImage ?? "",
                                        post.pricePay!);
                                  } else {
                                    return Container();
                                  }
                                })
                            // } else {
                            //   return Container(
                            //     child: Center(
                            //       child: CircularProgressIndicator(),
                            //     ),
                            //   );
                            // }
                            // },
                            // ),
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
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
        ),
        floatingActionButton: Container(
          width: 120,
          height: 30,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            onPressed: () {
              // Navigate to the CreatePostPage when the FAB is pressed
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreatePostPage(
                            key: UniqueKey(),
                          )));
            },
            // icon:Icon(Icons.add),
            label: Text(
              'Create Post',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
            tooltip: 'Create Post',
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(8))), // Make the FAB square
          ),
        ),
        floatingActionButtonLocation: CustomFABLocation(
          FloatingActionButtonLocation.centerFloat,
          offsetX: 0,
          offsetY: 0,
        ),
      ),
    );
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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => postDetailPage()));
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
                  postby,
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
  // print( 'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
  return distanceInKilometers;
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
            // BlocProvider.of<PostBloc>(context).add(getPostByType(FindJobClick));
            FindJobClick = !FindJobClick;

            if (FindJobClick) {
              print("1");
              BlocProvider.of<PostBloc>(context).add(getPostByType(true));
            } else {
              print("2");
              BlocProvider.of<PostBloc>(context).add(getPostByType(false));
            }
            if (FindJobClick && HireJobClick ||
                !FindJobClick && !HireJobClick) {
              BlocProvider.of<PostBloc>(context).add(getPostData());
            }
            print("FindJobClick: $FindJobClick HireJobClick: $HireJobClick");
          },
          child: Center(
            child: Container(
              width: 140.w,
              height: 30.h,
              // color: Colors.white,
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: FindJobClick ? Colors.white : Colors.transparent,
                  border: Border.all(
                      color: FindJobClick
                          ? Colors.white
                          // : Color.fromRGBO(224, 195, 252, 0.918),

                          : Color.fromRGBO(83, 82, 125, 0.3),
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 2.0),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 5,
                        color:
                            Color.fromARGB(255, 255, 255, 255).withOpacity(0.5))
                  ]),
              child: Center(
                child: Text(
                  'รับจ้าง',
                  style: TextStyle(
                    color: FindJobClick
                        ? Colors.black
                        : Colors.black.withOpacity(0.5),
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
            HireJobClick = !HireJobClick;
            if (HireJobClick) {
              print("HireJobClick = true iff: $HireJobClick");
              BlocProvider.of<PostBloc>(context).add(getPostByType(false));
            } else {
              BlocProvider.of<PostBloc>(context).add(getPostByType(true));
            }
            if (FindJobClick && HireJobClick ||
                !FindJobClick && !HireJobClick) {
              BlocProvider.of<PostBloc>(context).add(getPostData());
            }
            print("HireJobClick: $HireJobClick");
          },
          child: Center(
            child: Container(
              width: 140.w,
              height: 30.h,
              decoration: BoxDecoration(
                  color: HireJobClick ? Colors.white : Colors.transparent,
                  border: Border.all(
                      color: HireJobClick
                          ? Colors.white
                          : Color.fromRGBO(83, 82, 125, 0.3),
                          // : Color.fromRGBO(224, 195, 252, 0.918),
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 2.0),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 3,
                        color:
                            Color.fromARGB(255, 255, 255, 255).withOpacity(0.5))
                  ]),
              child: Center(
                child: Text(
                  'จ้างงาน',
                  style: TextStyle(
                    // color: HireJobClick ? Colors.white : Colors.black,

                    color: HireJobClick
                        ? Colors.black
                        : Colors.black.withOpacity(0.5),
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
