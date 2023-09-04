import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';

import '../common_widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
      return BlocBuilder<RegisterBloc,RegisterStates>( builder: (context,states) {
          return Container(
            color: Colors.white,
            child: SafeArea(
                child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar("Sign UP"),
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
                            reusableText("username"),
                            SizedBox(
                              height: 5.h,
                            ),
                            buildTextField(
                                "Enter your username", "username", Icons.lock,
                                (value) {
                              context.read<RegisterBloc>().add(UserNameEvent(value));
                            }),
                            reusableText("email"),
                            buildTextField(
                                "Enter email adress", "email", Icons.person,
                                (value) {
                              context.read<RegisterBloc>().add(EmailEvent(value));
                            }),
                            reusableText("password"),
                            buildTextField(
                                "Enter your password", "password", Icons.lock,
                                (value) {
                              context.read<RegisterBloc>().add(PasswordEvent(value));
                            }),
                            reusableText("Confirm Password"),
                            buildTextField(
                                "Enter your password", "password", Icons.lock,
                                (value) {
                              context.read<RegisterBloc>().add(RePasswordEvent(value));
                            }),
                          ]),
                    ),
                    buildLoginButton("Sign Up", () {
                      // SignInController(context: context).handleSignIn("email");
                      RegisterController(context:context).handleEmailRegister();
                      print("login button");
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 125.w, right: 25.w),
                        )
                  ],
                ),
              ),
            )),
          );
        }
      );
  }
}
