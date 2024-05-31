import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/editProfile/Widgets/editprofile_widget.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_state.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_image.dart';

import '../../model/usermodel.dart';

class editbioPage extends StatefulWidget {
  const editbioPage({super.key});

  @override
  State<editbioPage> createState() => _editbioPageState();
}

class _editbioPageState extends State<editbioPage> {
  final uid = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    context
        .read<EditProfileBloc>()
        .add(EditImageEvent(uid: FirebaseAuth.instance.currentUser!.uid));
  }
    UserModel? userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      userModel = state.userModelProfile;
      print(state.userModelProfile);
      print("state in bio = ${state.toString()}");
      if (state is InitialState) {
        return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      }
      print("state bio = ${state.userModelProfile?.bio??'a'}");
      // print("state bio = ${state.userModel!.bio}");
      return Container(
        color: Colors.white,
        child: Scaffold(
          appBar: 
               buildAppBarEditProfile(context,),
          body: _showBio(context, userModel),
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
    });
  }
}

Widget _showBio(BuildContext context, [UserModel? userModel]) {
  final TextEditingController _bioController = TextEditingController();
  return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
    _bioController.text = userModel?.bio ?? '';
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // FocusScope.of(context).unfocus();
            },
            child: TextField(
              controller: _bioController,
              // onChanged: (value) {
              //   print(_bioController.text);
              //   state.userModel!.bio = _bioController.text;
              // },
              onChanged: (value) => context
                  .read<EditProfileBioBloc>()
                  .add((BioEvent(_bioController.text))),
          
              enabled: true,
              decoration: InputDecoration(
                // hintText: state.userModel!.bio,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              BlocProvider.of<EditProfileBloc>(context)
                  .add(updateProfileBioEvent(_bioController.text));
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
        ],
      ),
    );
  });
}

AppBar buildAppBarEditProfile(context, [String? bio]) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.cancel_sharp),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            BlocProvider.of<EditProfileBloc>(context)
                .add(updateProfileBioEvent(bio!));
          },
        )
      ],
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withOpacity(0.5),
            height: 1.0,
          )),
      title: Text(
        "bio",
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal),
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
