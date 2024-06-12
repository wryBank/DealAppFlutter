import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import '../editProfile/bloc/editprofile_bloc.dart';
import '../editProfile/bloc/editprofile_event.dart';
import 'application_widgets.dart';

class ApplicationPage extends StatefulWidget {
  final int initialIndex;
  const ApplicationPage({this.initialIndex = 0});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
        print(position);
  }
  // ...

  Timer? _timer;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    // getLocation();
    // _timer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   getLocation();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
 
              body: buildPage(_index),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    _index = value;
                  });
                  if (value == 2) {
                    // BlocProvider.of<EditProfileBloc>(context)
                    //     .add(EditImageEvent(userModel: UserModel()));
                  }
                },
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                      label: "home",
                      icon: SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: Image.asset("assets/images/icon.png"),
                      )),
                  BottomNavigationBarItem(
                      label: "home2",
                      icon: SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: Image.asset("assets/images/icon.png"),
                      )),
                  BottomNavigationBarItem(
                      label: "home3",
                      icon: SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: Image.asset("assets/images/icon.png"),
                      )),
                ],
              ))),
    );
  }
}
