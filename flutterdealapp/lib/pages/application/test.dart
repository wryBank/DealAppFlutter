// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutterdealapp/CustomFABLocation.dart';
// import 'package:flutterdealapp/model/postmodel.dart';
// import 'package:flutterdealapp/pages/createpost/createPost_page.dart';
// import 'package:flutterdealapp/pages/editProfile/editprofile_page.dart';
// import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
// import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
// import 'package:flutterfire_ui/firestore.dart';
// import 'package:geolocator/geolocator.dart';

// import '../../values/color.dart';
// import '../post/bloc/post_event.dart';

// class test extends StatefulWidget {
//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   Future<void> getLocation() async {
//     await Geolocator.checkPermission();
//     await Geolocator.requestPermission();
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     print(position);
//     currentLatitude = position.latitude;
//     currentLongtitude = position.longitude;
//   }

//   double currentLatitude = 0;
//   double currentLongtitude = 0;

//   @override
//   void initState() {
//     super.initState();
//     getLocation().then((_) {
//       // getLocation2();
//       BlocProvider.of<PostBloc>(context).add(getPostData());

//       // uploadRandom();
//     });
//   }

//   // final queryPost = FirebaseFirestore.instance
//   //     .collection('posts').orderBy('detail')
//   //     .withConverter<PostModel>(
//   //       fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
//   //       toFirestore: (user, _) => user.toJson(),
//   //     );
//   // void uploadRandom() async {
//   //   print("inra");
//   //   final postColl = FirebaseFirestore.instance
//   //       .collection('posts')
//   //       .withConverter<PostModel>(
//   //         fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
//   //         toFirestore: (post, _) => post.toJson(),
//   //       );
//   //   final numbers = List.generate(2, (index) => index + 1);
//   //   for (final number in numbers) {
//   //     final post = PostModel(
//   //         uid: FirebaseAuth.instance.currentUser!.uid,
//   //         title: 'Post $number',
//   //         detail: 'Detail $number',
          
//   //         postimage:
//   //             "https://firebasestorage.googleapis.com/v0/b/dealapp-363e7.appspot.com/o/files%2F%E0%B9%86.png?alt=media&token=9937d410-adab-4b66-a08e-a3d246de6236",
//   //         postby: 'Username',
//   //         latitude: 13.736717,
//   //         longitude: 100.523186,
//   //         postdate: Timestamp.now());
//   //     postColl.add(post);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(onRefresh: () async {
//         getLocation();
//         BlocProvider.of<PostBloc>(context).add(getPostData());
//       }, child: BlocBuilder<PostBloc, PostState>(
//         builder: (context, state) {
//           if (state is PostInitial || state is PostLoading) {
//             return CircularProgressIndicator();
//           }
//           // if (state is PostListLoaded) {
//           //   print("state.postModel: ${state.postModel.toString()}");
//           //   // print("state.postModel: ${state.detail}");

//           // }
//           // if (state is PostListLoaded) {
//           //   print("state.postModel: ${state.postModel}\n ");
//           //   return ListView.builder(
//           //       itemCount: state.postModel.length,
//           //       itemBuilder: (context, index) {

//           //         var postWithDistance = state.postModel[index];
//           //         var post = postWithDistance['post']as PostModel; ;
//           //         var distance = postWithDistance['distance'] as double;
//           //         // final post = state.postModel[index];
//           //         return buildPostBox(post.title!, post.detail!, "",
//           //             post.postimage ?? "", "a", post.postdate!,distance);
//           //       });
//           // }
//           if (state is PostLoaded) {
//             // print("state.postModel: ${state.postModel}");
//             return FirestoreListView(
//                 query: state.postModel,
//                 pageSize: 2,
//                 itemBuilder: (context, snapshot) {
//                   final post = snapshot.data();
//                   print(post);

//                   // double distance = 0.0;

//                   double distance = calculateDistances(currentLatitude,
//                       currentLongtitude, post.latitude!, post.longitude!);
//                   // print("poss: ${post.postimage}");
//                   // print("poss: ${post.title}");
//                   return buildPostBox(post.title!, post.detail!, "",
//                       post.postimage ?? "", "a", post.postdate!, distance,post.profileImage??"");
//                 });
//           }
//           return Container(); // Add this line to return a non-null Widget
//         },
//       )),
//       floatingActionButton: Container(
//         width: 120,
//         height: 30,
//         child: FloatingActionButton.extended(
//           onPressed: () {
//             // Navigate to the CreatePostPage when the FAB is pressed
//             Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage(key: UniqueKey(),)));
            
//           },
//           // icon:Icon(Icons.add),
//           label: Text('Create Post'),
//           tooltip: 'Create Post',
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8))), // Make the FAB square
              
//         ),
//       ),
//       floatingActionButtonLocation: CustomFABLocation(
//         FloatingActionButtonLocation.centerFloat,
//         offsetX: 0,
//         offsetY: 0,
//       ),
//     );
//   }
// }

// Widget buildPostBox(String title, String detail, String location,
//     String urlImage, String postby, Timestamp postdate, double distance,String userImage) {
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
//                     backgroundImage: NetworkImage(userImage),
                    
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
//   return distanceInKilometers;
// }
