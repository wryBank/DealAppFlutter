import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../values/color.dart';

class test extends StatefulWidget {
  @override
  State<test> createState() => _testState();

}

class _testState extends State<test> { 
  @override
  void initState() {
    super.initState();
    // uploadRandom();
  }
  final queryPost = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<PostModel>(
        fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
  // void uploadRandom() async {
  //   print("inra");
  //   final postColl = FirebaseFirestore.instance
  //       .collection('posts')
  //       .withConverter<PostModel>(
  //         fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
  //         toFirestore: (post, _) => post.toJson(),
  //       );
  //   final numbers = List.generate(50, (index) => index + 1);
  //   for (final number in numbers) {
  //     final post = PostModel(
  //       title: 'Post $number',
  //       detail: 'Detail $number',
  //       postimage:
  //           'https://cdn.discordapp.com/attachments/756464270866120779/1249701504030478336/Rectangle_36.png?ex=666842b8&is=6666f138&hm=159dc4612cd2d66f905ddf37d7e9b2f489ec66cdfd55834d471b45a994507d4e&',
  //       postby: 'Username',
  //      postdate: Timestamp.now()

  //     );
  //     postColl.add(post);
  //   }
  // }

 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FirestoreListView(
            query: queryPost,
            pageSize: 2,
            itemBuilder: (context, snapshot) {
              final post = snapshot.data();
              print("poss: ${post.postimage}");
              print("poss: ${post.title}");
              return buildPostBox(
                  post.title!, post.detail!, "", post.postimage ?? "", "a",post.postdate!);
            })
            );
  }
}

Widget buildPostBox(String title, String detail, String location,
    String urlImage, String postby,Timestamp postdate) {
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
              child: Text("${postdate.toDate().day}/${postdate.toDate().month}/${postdate.toDate().year}"),
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
                  "22 km",
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