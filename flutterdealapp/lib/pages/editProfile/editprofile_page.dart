import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/Profile/bloc/profile_bloc.dart';
import 'package:flutterdealapp/pages/UserBloc/bloc/user_bloc.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/UserBloc/user_repo.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/common_widgets.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_image.dart';
import 'package:flutterdealapp/pages/editProfile/edtibio_page.dart';
import 'package:flutterdealapp/pages/editProfile/edtigender_page.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';
import 'package:flutterdealapp/service/shared_preferences_service.dart';
import 'package:flutterdealapp/widgets/flutter_toast.dart';
import 'package:image_picker/image_picker.dart';

import '../../values/color.dart';
import 'Widgets/editprofile_widget.dart';
import 'bloc/editprofile_event.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    // TODO: implement initStateeB
    BlocProvider.of<ProfileBloc>(context)
        .add(getUserData(uid: FirebaseAuth.instance.currentUser!.uid));
  }

  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        print("state1 = ${state.toString()}");
        if (state is LoadingState) {
          return Container(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        print("in getdatastate");
        return Scaffold(
          appBar: buildAppBarEditProfile(context, "showprofile"),
          body: SafeArea(
              child: Scaffold(
            // backgroundColor: Colors.white,
            // appBar: buildAppBarEditProfile(
            //     context, "test", state.userModel!.urlprofileimage!),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // Color.fromRGBO(207, 162, 250,100),
                    // Color.fromRGBO(194, 233, 251, 100),

                    Color.fromRGBO(224, 195, 252, 90),
                    Color.fromRGBO(142, 197, 252, 90),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _showImageSelect(
                      context,
                    ),
                    SizedBox(
                      height: 250.h,
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
        // else {
        // print("url state =  ${state.imageFile.toString()}");
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            // appBar: state is getDataState
            //     ? buildAppBarEditProfile(context, "test", state.imageFile!)
            //     : buildAppBarEditProfile(
            //         context,
            //         "showprofile",
            //       ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _showImageSelect(
                    context,
                  )
                ],
              ),
            ),
          )),
        );
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
        //   else {
      },
    );
  }
}

Widget _showImageSelect(
  BuildContext context,
) {
  PlatformFile? pickedFile;
  UserModel userModel1 = UserModel();

  return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
    if (state is getDataState) {
      print("state is getdatastate");
      print("bio = ${state.userModel!.bio}");

      return Column(
        children: [
          SizedBox(
            height: 34.h,
          ),
          GestureDetector(
            onTap: () async {
              print("click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfileimage()));
            },
            child: Stack(children: [
              CircleAvatar(
                radius: 60.r,
                backgroundImage:
                    NetworkImage(state.userModel!.urlprofileimage!),
              )
            ]),
          ),
          GestureDetector(
            onTap: () async {
              print("click");
              // selectFile();
              final ImagePicker _picker = ImagePicker();
              if (_picker != null) {}
              print("tap tap");
            },
            child: Container(
              child: Center(
                  child: Text(
                "แก้ไขรูปภาพ",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 128, 255),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.normal),
              )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText("Username"),
                GestureDetector(
                  onTap: () {
                    print("tap username ");
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => editbioPage()));
                  },
                  child: Container(
                    child: buildTextFieldToShowInEditProfilePage(
                        state.userModel!.username),
                  ),
                ),
                SizedBox(height: 10.h),
                reusableText("bio"),
                GestureDetector(
                  onTap: () {
                    print("tap textfield editbio");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => editbioPage()));
                  },
                  child: Container(
                    child: buildTextFieldToShowInEditProfilePage(
                        state.userModel!.bio),
                  ),
                ),
                SizedBox(height: 10.h),
                reusableText("email"),
                GestureDetector(
                  onTap: () {
                    print("tap textfield editbio");
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => editbioPage()));
                    toastInfo(msg: "Can't edit email");
                  },
                  child: Container(
                    child: buildTextFieldToShowInEditProfilePage(
                        state.userModel!.email),
                  ),
                ),
                SizedBox(height: 10.h),
                reusableText("Gender"),
                GestureDetector(
                  onTap: () {
                    print("tap textfield Gender");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => editgenderPage()));
                    // toastInfo(msg: "Can't edit email");
                  },
                  child: Container(
                    child: buildTextFieldToShowInEditProfilePage(
                        state.userModel!.gender),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: buildCommonButton("Logout", () {
              // FirebaseAuth.instance.signOut();
              ShardPreferencesService().removeCache(key: 'email');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("signIn", (route) => false);
            }),
          )
          // Container(

          //   child: GestureDetector(
          //     onTap: () {
          //       print("tap textfield editbio");
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => editbioPage()));
          //     },
          //     child: Container(
          //       child: TextField(
          //         enabled: false,
          //         decoration: InputDecoration(
          //           hintText: state.userModel!.bio,
          //           hintStyle: TextStyle(
          //               color: Colors.black,
          //               fontSize: 14.sp,
          //               fontWeight: FontWeight.normal),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );
    } else {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  });
}

AppBar buildAppBarEditProfile(context, String type, [PlatformFile? imagePath]) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Color.fromRGBO(207, 162, 250,100),
              // Color.fromRGBO(194, 233, 251, 100),

              Color.fromRGBO(224, 195, 252, 90),
              Color.fromRGBO(142, 197, 252, 90),
            ],
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("Application", (route) => false);
        },
      ),
      // bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(1.0),
      //     child: Container(
      //       color: Colors.grey.withOpacity(0.5),
      //       height: 1.0,
      //     )
      //     ),
      title: Text(
        type,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal),
      ),
    );
  }