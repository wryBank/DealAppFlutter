import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar() {
  return AppBar(
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1.0,
        )),
    title: Text(
      "Logian",
      style: TextStyle(
          color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.normal),
    ),
  );
}

//need context for accessing bloc
Widget buildThirdPartLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: 40.h,
      bottom: 20.h
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
    children: [
      _reusableIcons("google"),
      _reusableIcons("facebook"),
    ]),
  );
}

Widget _reusableIcons(String iconName) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.2,
                blurRadius: 6,
                offset: Offset(0, 1))
          ]),
      width: 40.w,
      height: 40.w,
      child: Image.asset("assets/icons/${iconName}.png"),
    ),
  );
}
Widget reusableText(String text){
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.9),
        fontWeight: FontWeight.normal,
        fontSize: 14.sp
      ),
      
    ),

  );
}
Widget buildTextField(String text, String textType){
  return Container(
    width: 325.w,
    height: 50.h,
    decoration: BoxDecoration(
      color:Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(15.w)),
      border: Border.all(color: Colors.black)
    ),
    child:Row(children: [
      Container(
        width: 16.w,
        margin: EdgeInsets.only(left: 12.w),
        height: 16.w,
        child: Icon(Icons.person)
      )
    ],)
  );
  
}
