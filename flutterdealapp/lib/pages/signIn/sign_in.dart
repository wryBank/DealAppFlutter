import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_events.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_state.dart';
import 'package:flutterdealapp/pages/signIn/widgets/sign_in_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 250.w,
                    height: 150.h,
                    child: Image.asset(
                      "assets/images/icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText("email"),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField(
                            "Enter email adress", "email", Icons.person,
                            (value){
                              context.read<SignInBloc>().add(EmailEvent(value));
                            }),
                        reusableText("password"),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField(
                            "Enter your password", "password", Icons.lock,
                            (value){
                              context.read<SignInBloc>().add(passwordEvent(value));
                            }),
                      ]),
                ),
                buildLoginAndRegisterButton("LOGIN"),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                    child: reusableText("Or use your email account to login")),
                buildThirdPartLogin(context),
                Center(
                  child: reusableText("Don't have an account ? "),
                ),
                Container(
                    padding: EdgeInsets.only(left: 125.w, right: 25.w),
                    child: SignUp())
              ],
            ),
          ),
        )),
      );
    });
  }
}
