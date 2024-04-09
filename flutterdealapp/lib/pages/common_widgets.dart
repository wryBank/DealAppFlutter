import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/values/color.dart';


AppBar buildAppBarEditProfile(String type){
  return AppBar(
    automaticallyImplyLeading: false,
    
    leading: IconButton(
      icon: Icon(Icons.cancel_sharp),
      onPressed: (){},
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.check),
        onPressed: (){},
      )
    ],
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1.0,
        )),
    title: Text(
      type,
      style: TextStyle(
          color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.normal),
    ),
  );

}

AppBar buildAppBar(String type) {
  return AppBar(
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1.0,
        )),
    title: Text(
      type,
      style: TextStyle(
          color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.normal),
    ),
  );
}

//need context for accessing bloc
Widget buildThirdPartLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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

Widget reusableText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.grey.withOpacity(0.9),
          fontWeight: FontWeight.normal,
          fontSize: 14.sp),
    ),
  );
}
Widget buildTextField2(String hinttext, String textType, IconData iconName,TextEditingController controller,
) {
  return Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Container(
            width: 16.w,
            margin: EdgeInsets.only(left: 12.w),
            height: 16.w,
            child: Icon(iconName),
          ),
          Container(
            width: 270.w,
            height: 50.h,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              decoration:  InputDecoration(
                hintText: hinttext,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    )
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

Widget buildTextField(String hinttext, String textType, IconData iconName,
void Function(String value)?func
) {
  return Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Container(
            width: 16.w,
            margin: EdgeInsets.only(left: 12.w),
            height: 16.w,
            child: Icon(iconName),
          ),
          Container(
            width: 270.w,
            height: 50.h,
            child: TextField(
              onChanged: (value)=>func!(value),
              keyboardType: TextInputType.multiline,
              decoration:  InputDecoration(
                hintText: hinttext,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    )
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
Widget buildLoginButton(String buttonName, void Function()? func){
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 180.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 150.w,right: 25.w,),
      decoration: BoxDecoration(
        color: AppColors.primaryButton,
        borderRadius: BorderRadius.circular(30.w),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius:3, 
            offset: Offset(0,3),
            color: Colors.grey.withOpacity(0.5)
          )
        ]
      ),
      child: Center(child: Text(buttonName,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white
      ),
      
      )),
    ),
  );
}
Widget SignUp(void Function()?func){
  return Container(
    margin: EdgeInsets.only(left: 25.w),
    width: 260.w,
    height: 44.h,
    child: GestureDetector(
      onTap: func,
      child: Text("Sign up" ,
      style: TextStyle(
        color: AppColors.primaryButton,
        fontSize: 12.sp
      ),
      
      ),
      
    ),
    
  );
}
