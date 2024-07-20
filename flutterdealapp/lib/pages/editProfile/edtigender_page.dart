import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/common_widgets.dart';
import 'package:flutterdealapp/pages/editProfile/Widgets/editprofile_widget.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_state.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileGender_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileGender_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileGender_state.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_image.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_page.dart';

import '../../model/usermodel.dart';
import '../Profile/bloc/profile_bloc.dart';

class editgenderPage extends StatefulWidget {
  const editgenderPage({super.key});

  @override
  State<editgenderPage> createState() => _editgenderPageState();
}

class _editgenderPageState extends State<editgenderPage> {
  final uid = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    // context
    //     .read<EditProfileBloc>()
    //     .add(EditImageEvent(uid: FirebaseAuth.instance.currentUser!.uid));
    BlocProvider.of<ProfileBloc>(context)
        .add(getUserData(uid: FirebaseAuth.instance.currentUser!.uid));
  }

  UserModel? userModel = UserModel();

  String? dropdownValue = 'None';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      // userModel = state.userModelProfile;
      // print(state.userModelProfile);
      print("state in bio = ${state.toString()}");
      // if (state is InitialState  ) {
      //   return Container(
      //       color: Colors.white,
      //       child: Center(
      //         child: CircularProgressIndicator(),
      //       ));
      // }
      // print("state bio = ${state.userModelProfile?.bio ?? 'a'}");
      // print("state bio = ${state.userModel!.bio}");
      if (state is getDataState) {
        // userModel = state.userModelProfile;
        userModel = state.userModel;
        dropdownValue = state.userModel?.gender;

        // print("state bio2 = ${state.userModelProfile?.bio ?? 'a'}");
        return Container(
          color: Colors.white,
          child: Scaffold(
            appBar: buildAppBarEditProfile(
              context,
            ),
            body: Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // Color.fromRGBO(207, 162, 250,100),
                      // Color.fromRGBO(194, 233, 251, 100),

                      Color.fromRGBO(224, 195, 252, 100),
                      Color.fromRGBO(142, 197, 252, 100),
                    ],
                  ),
                  // border: Border.all(
                  //   width: 0.2,
                  //   color: Colors.black,
                  // ),
                  // borderRadius: BorderRadius.circular(25),
                ),
                child: _showBio(context, userModel, dropdownValue)),
            // body: Container(
            //   child: TextField(
            //     controller: _bioController,
            //     // onChanged: (value) {
            //     //   print(_bioController.text);
            //     //   state.userModel!.bio = _bioController.text;
            //     // },
            //     onChanged: (value) => context
            //         .read<EditProfileBioBloc>()
            //         .add((BioEvent(_bioController.text))),

            //     enabled: true,
            //     decoration: InputDecoration(
            //       // hintText: state.userModel!.bio,
            //       hintStyle: TextStyle(
            //           color: Colors.black,
            //           fontSize: 14.sp,
            //           fontWeight: FontWeight.normal),
            //     ),
            //   ),
            // ),
          ),
        );
      } else {
        return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      }
    });
  }
}

Widget _showBio(
    BuildContext context, UserModel? userModel, String? dropdownValue) {
  print(userModel);
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _GenderController = TextEditingController();
  // return BlocBuilder<EditProfileBloc, EditProfileState>(
  //     builder: (context, state) {
  // _bioController.text = state.userModelProfile?.bio ?? '';
  _bioController.text = userModel?.bio ?? '';
  print("inbloc${userModel}");
  return Container(
    margin: EdgeInsets.only(top: 16.h),
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
    child: Column(
      children: [
        // GestureDetector(
        //   onTap: () {
        //     // FocusScope.of(context).unfocus();
        //   },
        //   child: TextField(
        //     controller: _bioController,
        //     // onChanged: (value) {
        //     //   print(_bioController.text);
        //     //   state.userModel!.bio = _bioController.text;
        //     // },
        //     onChanged: (value) => context
        //         .read<EditProfileBioBloc>()
        //         .add((BioEvent(_bioController.text))),

        //     enabled: true,
        //     decoration: InputDecoration(
        //       // hintText: state.userModel!.bio,
        //       hintStyle: TextStyle(
        //           color: Colors.black,
        //           fontSize: 14.sp,
        //           fontWeight: FontWeight.normal),
        //     ),
        //   ),
        // ),
        // DropdownMenu(
        //   // enabled: tr,
        //   dropdownMenuEntries: [
        //     DropdownMenuEntry(value: "Male", label: "Male"),
        //     DropdownMenuEntry(value: "Female", label: "Female"),
        //   ],
        //   controller: _GenderController,
        //   onSelected: (value) {
        //     print(value);
        //     _GenderController.text = value.toString();
        //   },
        // ),

        BlocBuilder<EditProfileGenderBloc, GenderState>(
            builder: (context, state) {
          // dropdownValue = dropdownValue;
          // state.userModelProfile = userModel;
          return DropdownButton<String>(
              value: dropdownValue,
              items: <String>['None', 'Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                dropdownValue = value;
                context
                    .read<EditProfileGenderBloc>()
                    .add((GenderEvent(value.toString())));
                // state.userModelProfile?.gender ;
                // state.userModelProfile?.gender = value.toString();
                print(value);
                // print(state.userModelProfile?.gender);
                // print(state.userModelProfile);
                print(state);
                print("${userModel}");
                print(dropdownValue);
              });
        }),
        // GestureDetector(
        //   onTap: () async {
        //     BlocProvider.of<EditProfileBloc>(context)
        //         .add(updateProfileBioEvent(_bioController.text));
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => EditProfilePage()));
        //     // Navigator.of(context).pushNamed("Application");
        //   },
        SizedBox(
          height: 35.h,
        ),
        buildCommonButton("SaveData", () async {
          BlocProvider.of<EditProfileBloc>(context)
              .add(updateProfileGenderEvent(dropdownValue!));
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditProfilePage()));
        }),
        // child: Container(
        //   child: Center(
        //       child: Text(
        //     userModel?.bio ?? 'bio',
        //     style: TextStyle(
        //         color: Color.fromARGB(255, 0, 128, 255),
        //         fontSize: 24.sp,
        //         fontWeight: FontWeight.normal),
        //   )),
        // ),
        // ),
      ],
    ),
  );
  // });
}

AppBar buildAppBarEditProfile(context, [String? bio]) {
  return AppBar(
    automaticallyImplyLeading: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        // color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color.fromRGBO(207, 162, 250,100),
            // Color.fromRGBO(194, 233, 251, 100),

            Color.fromRGBO(224, 195, 252, 100),
            Color.fromRGBO(142, 197, 252, 100),
          ],
        ),
        // border: Border.all(
        //   width: 0.2,
        //   color: Colors.black,
        // ),
        // borderRadius: BorderRadius.circular(25),
      ),
    ),
    // leading: IconButton(
    //   icon: Icon(Icons.cancel_sharp),
    //   onPressed: () {},
    // ),
    // actions: [
    //   IconButton(
    //     icon: Icon(Icons.check),
    //     onPressed: () {
    //       BlocProvider.of<EditProfileBloc>(context)
    //           .add(updateProfileBioEvent(bio!));
    //     },
    //   )
    // ],
 
    title: Text(
      "bio",
      style: TextStyle(
          color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.normal),
    ),
  );
  // else {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     leading: IconButton(
  //       icon: Icon(Icons.cancel_sharp),
  //       onPressed: () {},
  //     ),
  //     // actions: [
  //     //   IconButton(
  //     //     icon: Icon(Icons.check),
  //     //     onPressed: () {
  //     //       BlocProvider.of<EditProfileBloc>(context)
  //     //           .add(updateProfileBioEvent(bio));
  //     //     },
  //     //   )
  //     // ],
  //     bottom: PreferredSize(
  //         preferredSize: const Size.fromHeight(1.0),
  //         child: Container(
  //           color: Colors.grey.withOpacity(0.5),
  //           height: 1.0,
  //         )),
  //     title: Text(
  //       "bio",
  //       style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.normal),
  //     ),
  //   );
  // }
}
