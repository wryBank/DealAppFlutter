import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/color.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
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
        body: Column(children: <Widget>[
          Container(
              height: size.height * 0.2,
              child: Stack(children: <Widget>[
                Container(
                    height: size.height * 0.4 - 47,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 88, 172, 255),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26),
                      ),
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
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  //   backgroundImage: NetworkImage(
                                  //       // state.userModel!.urlprofileimage!),
                                  // ),
                                ),
                              ),
                            ),
                          )
                        ])),
              ])),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  buildPostBox();
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Builder(builder: (context) {
                      return Material(
                        child: buildPostBox(),
                      );
                      // return Material(
                      //   child: ListView(

                      //   ),
                      // );
                    }),
                  );
                }),
          ),
        ]));
  }
}

Widget buildPostBox() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.green,
      border: Border.all(
        width: 3,
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.all(20),
    child: Column(
      children: [
        Container(
          color: Colors.red,
          margin: EdgeInsets.all(10),
          width: 235.w,
          height: 120.h,
          child: Image.asset("assets/images/icon.png"),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: Text("1 hour ago"),
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
                "This Heading",
                style: TextStyle(fontSize: 20),
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
                  child: Image.asset("assets/icons/location.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                "This is the body of the post",
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
  );
}
