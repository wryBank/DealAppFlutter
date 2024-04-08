import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
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
  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  UserModel userModel = UserModel();
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
                        ]),
                  ),
                  buildLoginButton("Next", () {
                    userModel.username = _usernameController.text;
                    userModel.phonenumber = _phoneNumberController.text;
                    userModel.email = uid!.email;
                    userModel.uid = uid!.uid;
                    BlocProvider.of<EditProfileBloc>(context).add(Create(userModel: userModel));
                    
              Navigator.of(context).pushNamedAndRemoveUntil("editprofileImage", (route) => false);
                    print("login button");
                    print(userModel.uid.toString());
                    print(userModel.username.toString());
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
