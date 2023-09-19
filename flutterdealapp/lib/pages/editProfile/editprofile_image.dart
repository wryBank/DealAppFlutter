import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_provider.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';

import '../../values/color.dart';
import '../common_widgets.dart';
import 'bloc/editprofile_event.dart';

class EditProfileimage extends StatefulWidget {
  const EditProfileimage({super.key});

  @override
  State<EditProfileimage> createState() => _EditProfileimageState();
}

class _EditProfileimageState extends State<EditProfileimage> {
  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        // if(state is LoadingState || state is InitialState){
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        if (state is uploadingImageState) {
          // print("url state =  ${state.imageFile.toString()}");
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
                    _upLoadImage(context, "2", "title", "subtile",state.url.toString()),
                        
                    // Center(
                    //   child: SizedBox(
                    //     width: 250.w,
                    //     height: 150.h,
                    //     child: Image.asset(
                    //       "assets/images/icon.png",
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 16.h),
                    //   padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    //   child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       // children: [
                    //       //   reusableText("username"),
                    //       //   SizedBox(
                    //       //     height: 5.h,
                    //       //   ),
                    //       //   buildTextField2("Enter your username", "username",
                    //       //       Icons.lock, _usernameController),
                    //       //   reusableText("email"),
                    //       //   buildTextField2("Enter email adress", "email",
                    //       //       Icons.person, _phoneNumberController),
                    //       // ]
                    //       ),
                    // ),
                    // buildLoginButton("Next", () {
                    //   userModel.username = _usernameController.text;
                    //   userModel.phonenumber = _phoneNumberController.text;
                    //   userModel.uid = uid!.uid;
                    //   // SignInController(context: context).handleSignIn("email");
                    //   // RegisterController(context:context).handleEmailRegister();
                    //   // BlocProvider.of<EditProfileBloc>(context)
                    //   //     .add(EditProfileEvent());
                    //   BlocProvider.of<EditProfileBloc>(context) .add(Create(userModel:userModel));
                    //   print("login button");
                    //   print(userModel.uid.toString());
                    //   print(userModel.username.toString());
                    // }),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 125.w, right: 25.w),
                    // )
                  ],
                ),
              ),
            )),
          );
        } else {
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
                    _upLoadImage(context, "2", "title", "subtile", "path"),
                  ],
                ),
              ),
            )),
          );
        }
      },
    );
  }
}

Widget _upLoadImage(BuildContext context, String buttonName, String title,
    String subTitle, String imagePath) {
  PlatformFile? pickedFile;
  Future selectFile() async {
    // Uint8List img = await pickImage(ImageSource.gal)
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    pickedFile = result.files.first;
    BlocProvider.of<EditProfileBloc>(context)
        .add(uploadingImageEvent(imageFile: pickedFile));
  }

  return Column(
    children: [
      SizedBox(
        height: 34.h,
      ),
      GestureDetector(
        onTap: () {
          print("click");
          selectFile();
        },
        child: Stack(children: [
          CircleAvatar(
            radius: 90,
            backgroundImage: NetworkImage(imagePath),
            // backgroundImage: 
            // AssetImage('assets/images/defaultProfile.png'),
            backgroundColor: Colors.grey,
          ),
          
        ]),
      ),
      // SizedBox(
      //   width: 345.w,
      //   height: 345.w,
      //   child: Image.asset(
      //     imagePath,
      //     fit: BoxFit.cover,
      //   ),
      // ),
      Container(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        width: 375.w,
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Text(
          subTitle,
          style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14.sp,
              fontWeight: FontWeight.normal),
        ),
      ),
      GestureDetector(
        onTap: () {
          selectFile();
          BlocProvider.of<EditProfileBloc>(context)
              .add(uploadingImageEvent(imageFile: pickedFile));
        },
        child: Container(
          margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
          width: 325.w,
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.primaryButton,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 10))
              ]),
          child: Center(
            child: Text(
              "next",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      )
    ],
  );
}
