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
import 'package:flutterdealapp/pages/UserBloc/bloc/user_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_provider.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../values/color.dart';
import '../UserBloc/bloc/user_state.dart';
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
  String url1 = "https://cdn.discordapp.com/attachments/1155873224643592222/1226776671286202390/image.png?ex=6625ffce&is=66138ace&hm=02e25580d2564450be11c72201ee130b18007a57ccdd6a04367ab6c143f8a8da&";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        // if(state is LoadingState || state is InitialState){
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        // if (state is uploadingImageState) {
        if (state is showImageSelectState) {
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
                    _upLoadImage(context, "2", "title", "subtile",state.imageFile),
                  ],
                ),
              ),
            )),
          );
        } 
        else {
          print("inelse");
          return BlocBuilder<UserBloc,UserState>(
            builder: (context,state) {
              
              if (state is getProfileImageState) {
                url1 = state.url!;
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
                          _showImageSelect(context, "2", "title", "subtile" ,state.url!),
                        ],
                      ),
                    ),
                  )),
                );
              }
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
                        _showImageSelect(context, "2", "title", "subtile" ,url1),
                      ],
                    ),
                  ),
                )),
              );
            }
          );
        }
      },
    );
  }
}

Widget _upLoadImage(BuildContext context, String buttonName, String title,
    // String subTitle, String imagePath) {
    String subTitle, PlatformFile? imagePath) {
          print("in return");
  PlatformFile? pickedFile;
  // String? filePath = pickedFile?.path;

  Future selectFile() async {
    // Uint8List img = await pickImage(ImageSource.gal)
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    pickedFile = result.files.first;
    // BlocProvider.of<EditProfileBloc>(context)
    //     .add(uploadingImageEvent(imageFile: pickedFile));
    BlocProvider.of<EditProfileBloc>(context)
        .add(showImageSelect(imageFile: pickedFile));
  }
  return Column(
    children: [
      SizedBox(
        height: 34.h,
      ),
      GestureDetector(
        onTap: () async {
          print("click");
          selectFile();
        final ImagePicker _picker = ImagePicker();
        if(_picker != null){
        }
        },
        child: Stack(children: [
          CircleAvatar(
            radius: 90,
            // backgroundImage: NetworkImage(imagePath),
            backgroundImage: FileImage(File(imagePath!.path!)),
            // backgroundImage: 
            // AssetImage('assets/images/defaultProfile.png'),
            backgroundColor: Colors.grey,
          ),
          
        ]),
      ),
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
    BlocProvider.of<EditProfileBloc>(context)
        .add(uploadingImageEvent(imageFile: imagePath));
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

Widget _showImageSelect(BuildContext context, String buttonName, String title,
    String subTitle, String imagePath) {
    // String subTitle, PlatformFile? imagePath) {
  PlatformFile? pickedFile;
  Future selectFile() async {
    // Uint8List img = await pickImage(ImageSource.gal)
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    pickedFile = result.files.first;
    // BlocProvider.of<EditProfileBloc>(context)
    //     .add(uploadingImageEvent(imageFile: pickedFile));
    BlocProvider.of<EditProfileBloc>(context)
        .add(showImageSelect(imageFile: pickedFile));
  }
  return Column(
    children: [
      SizedBox(
        height: 34.h,
      ),
      GestureDetector(
        onTap: () async {
          print("click");
          selectFile();
        final ImagePicker _picker = ImagePicker();
        if(_picker != null){
        }
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
    // BlocProvider.of<EditProfileBloc>(context)
    //     .add(UploadUrlImageEvent(url: imagePath));
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
