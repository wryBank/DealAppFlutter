import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';

import '../common_widgets.dart';
import 'bloc/editprofile_event.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc,EditProfileState >(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("More information"),
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
                          buildTextField2("Enter your username", "username",
                              Icons.lock, _usernameController),
                          reusableText("email"),
                          buildTextField2("Enter email adress", "email",
                              Icons.person, _phoneNumberController),
                          reusableText("password"),
                        ]),
                  ),
                  buildLoginButton("Sign Up", () {
                    // SignInController(context: context).handleSignIn("email");
                    // RegisterController(context:context).handleEmailRegister();
                    // BlocProvider.of<EditProfileBloc>(context)
                    //     .add(EditProfileEvent());
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
      },
    );
  }
}
