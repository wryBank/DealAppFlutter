import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'application_widgets.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: buildPage(_index),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value){
              setState(() {
              _index = value;
                
              });
            },
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "home",
                icon: SizedBox(
                width: 15.w,
                height: 15.h,
                child: Image.asset("assets/images/icon.png")
              ,)
              ),
              BottomNavigationBarItem(
                label: "home2",
                icon: SizedBox(
                width: 15.w,
                height: 15.h,
                child: Image.asset("assets/images/icon.png")
              ,)
              ),

            ],
          )
        )),
    );
    
  }
}