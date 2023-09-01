import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/signIn/widgets/sign_in_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:Colors.white,
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top:66.h),
                  padding: EdgeInsets.only(left: 25.w,right: 25.w ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("email"),
                      buildTextField("Email", "email")
                  ]),
                ),
                buildThirdPartLogin(context),
                Center(child: reusableText("Or use your email account to login")),
              ],
            ),
          ),
      
      )),
    );
  }
}