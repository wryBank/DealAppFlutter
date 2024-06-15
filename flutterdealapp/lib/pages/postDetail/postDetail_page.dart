import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';

import '../../values/color.dart';

class postDetailPage extends StatefulWidget {
  const postDetailPage({super.key});

  @override
  State<postDetailPage> createState() => _postDetailPageState();
}

class _postDetailPageState extends State<postDetailPage> {
  @override
  Widget build(BuildContext context) {
    // PostModel postModel = PostModel();
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      // print(state.toString());
      
      if (state is postDetailLoaded) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Post Detail"),
          ),
            body: buildPostBox(
                context,
                state.postModel.title.toString(),
                state.postModel.detail.toString(),
                state.postModel.location_item.toString(),
                state.postModel.postimage.toString(),
                state.postModel.postby.toString(),
                state.postModel.postdate as Timestamp,
                1.0,
                state.postModel.profileImage.toString()));
      } 
      else {
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

Widget buildPostBox(
    context,
    String title,
    String detail,
    String location,
    String urlImage,
    String postby,
    Timestamp postdate,
    double distance,
    String userImage) {
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
        ],
      ),
    ),
  );
}
