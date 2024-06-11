import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../values/color.dart';
import '../post/bloc/post_event.dart';

class test extends StatefulWidget {
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    BlocProvider.of<PostBloc>(context).add(getPostListData());
    // uploadRandom();
  }

  // final queryPost = FirebaseFirestore.instance
  //     .collection('posts').orderBy('detail')
  //     .withConverter<PostModel>(
  //       fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
  //       toFirestore: (user, _) => user.toJson(),
  //     );
  // void uploadRandom() async {
  //   print("inra");
  //   final postColl = FirebaseFirestore.instance
  //       .collection('posts')
  //       .withConverter<PostModel>(
  //         fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
  //         toFirestore: (post, _) => post.toJson(),
  //       );
  //   final numbers = List.generate(5, (index) => index + 1);
  //   for (final number in numbers) {
  //     final post = PostModel(
  //       uid: 'uid $number',
  //       title: 'Post $number',
  //       detail: 'Detail $number',
  //       postimage:
  //           "https://firebasestorage.googleapis.com/v0/b/dealapp-363e7.appspot.com/o/files%2F%E0%B9%86.png?alt=media&token=9937d410-adab-4b66-a08e-a3d246de6236",
  //       postby: 'Username',
  //      postdate: Timestamp.now()

  //     );
  //     postColl.add(post);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(onRefresh: () async {
      getLocation();
      BlocProvider.of<PostBloc>(context).add(getPostListData());
    }, child: BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial || state is PostLoading) {
          return CircularProgressIndicator();
        }
        // if (state is PostListLoaded) {
        //   print("state.postModel: ${state.postModel.toString()}");
        //   // print("state.postModel: ${state.detail}");
          
        // }
        if (state is PostListLoaded) {
          print("state.postModel: ${state.postModel}\n ");
          return ListView.builder(
              itemCount: state.postModel.length,
              itemBuilder: (context, index) {
                
                var postWithDistance = state.postModel[index];
                var post = postWithDistance['post']as PostModel; ;
                var distance = postWithDistance['distance'] as double;
                // final post = state.postModel[index];
                return buildPostBox(post.title!, post.detail!, "",
                    post.postimage ?? "", "a", post.postdate!,distance);
              });
        }
        // if (state is PostLoaded) {
        //   // print("state.postModel: ${state.postModel}");
        //   return FirestoreListView(
        //       query: state.postModel,
        //       pageSize: 2,
        //       itemBuilder: (context, snapshot) {
        //         final post = snapshot.data();
        //         // print("poss: ${post.postimage}");
        //         // print("poss: ${post.title}");
        //         return buildPostBox(post.title!, post.detail!, "",
        //             post.postimage ?? "", "a", post.postdate!,);
        //       });
        // }
        return Container(); // Add this line to return a non-null Widget
      },
    )));
  }
}

Widget buildPostBox(String title, String detail, String location,
    String urlImage, String postby, Timestamp postdate,double distance) {
  return GestureDetector(
    onTap: () {
      print("tap in post box");
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
                color: Colors.amber,
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
            color: Colors.amber,
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
