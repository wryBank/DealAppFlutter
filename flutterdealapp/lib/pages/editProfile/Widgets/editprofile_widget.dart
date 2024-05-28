
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField(String hinttext, String textType, IconData iconName,
void Function(String value)?func
) {
  return Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(bottom: 20.h),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     // borderRadius: BorderRadius.all(Radius.circular(25.w)),
      //     border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Container(
            width: 16.w,
            margin: EdgeInsets.only(left: 12.w),
            height: 16.w,
            // child: Icon(iconName),
          ),
          Container(
            width: 270.w,
            height: 50.h,
            child: TextField(
              onChanged: (value)=>func!(value),
              keyboardType: TextInputType.multiline,
              decoration:  InputDecoration(
                hintText: hinttext,
              //   border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.transparent)),
              //   enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.transparent)),
              //   disabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.transparent)),
              //   focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.transparent)),
              //       hintStyle: TextStyle(
              //         color: Colors.grey.withOpacity(0.5),
              //       )
              ),
            style: TextStyle(
              color: Colors.black, 
              // fontFamily: 
              fontWeight: FontWeight.normal,
              fontSize: 14.sp
            ),
            autocorrect: false,
            obscureText: textType=="password"?true:false,
            ),
          )
        ],
      ));
}

Widget buildTextField_EditImage(String hinttext, String textType, IconData iconName,
void Function(String value)?func
) {
  return Column(
    children: [
      Container(
          width: 325.w,
          height: 50.h,
          margin: EdgeInsets.only(bottom: 20.h),
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     // borderRadius: BorderRadius.all(Radius.circular(25.w)),
          //     border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Container(
                width: 16.w,
                margin: EdgeInsets.only(left: 12.w),
                height: 16.w,
                // child: Icon(iconName),
              ),
              Container(
                width: 270.w,
                height: 50.h,
                child: TextField(
                  onChanged: (value)=>func!(value),
                  keyboardType: TextInputType.multiline,
                  decoration:  InputDecoration(
                    hintText: hinttext,
                  //   border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.transparent)),
                  //   enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.transparent)),
                  //   disabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.transparent)),
                  //   focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.transparent)),
                  //       hintStyle: TextStyle(
                  //         color: Colors.grey.withOpacity(0.5),
                  //       )
                  ),
                style: TextStyle(
                  color: Colors.black, 
                  // fontFamily: 
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp
                ),
                autocorrect: false,
                obscureText: textType=="password"?true:false,
                ),
              )
            ],
          )),
    ],
  );
}