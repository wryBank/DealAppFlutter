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
import 'package:flutterdealapp/pages/editProfile/edtibio_page.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';
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
  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  UserModel userModel = UserModel();
  String url1 = "";
  // user_repo userRepo = user_repo(provider: user_provider());
  // Future<UserModel> getUserData() async {
  //   return await userRepo.provider
  //       .getUserData(FirebaseAuth.instance.currentUser!.uid);
  // }

  // void getData() async {
  //   userModel = await getUserData();
  //   print(userModel);
  //   url1 = userModel.urlprofileimage!.toString();
  // }

  @override
  void initState() {
    // TODO: implement initStateeB
    context
        .read<EditProfileBloc>()
        .add(EditImageEvent(uid: FirebaseAuth.instance.currentUser!.uid));
    // getData();
  }

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
        // else {
        // print("url state =  ${state.imageFile.toString()}");
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: Colors.white,
            appBar: state is showImageSelectState
                ? buildAppBarEditProfile(context, "test", state.imageFile!)
                : buildAppBarEditProfile(
                    context,
                    "showprofile",
                  ),
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
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    pickedFile = result.files.first;
    BlocProvider.of<EditProfileBloc>(context)
        .add(showImageSelect(imageFile: pickedFile));
  }

  return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
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
            if (_picker != null) {}
          },
          child: Stack(children: [
            Center(
              child: BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                if (state is EditImageState) {
                  return CircleAvatar(
                    radius: 90,
                    backgroundImage:
                        NetworkImage(state.userModel!.urlprofileimage!),
                    backgroundColor: Colors.grey,
                  );
                }
                if (state is showImageSelectState) {
                  return CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(File(state.imageFile!.path!)),
                    backgroundColor: Colors.grey,
                  );
                }
                if (state is doneUploadState) {
                  return CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage(state.url!),
                    backgroundColor: Colors.grey,
                  );
                } else {
                  return CircleAvatar(
                    radius: 90,
                    child: CircularProgressIndicator(),
                    backgroundColor: Colors.grey,
                  );
                }
              }),
            ),
          ]),
        ),
        GestureDetector(
          onTap: () async {
            print("click");
            selectFile();
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
        // GestureDetector(
        //   onTap: () {
        //     print("tap textfield editbio");
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => editbioPage()));
        //   },
        //   child: Container(
        //     child: TextField(
        //       enabled: false,
        //       decoration: InputDecoration(
        //         hintText: state.userModel!.username,
        //         hintStyle: TextStyle(
        //             color: Colors.black.withOpacity(0.5),
        //             fontSize: 14.sp,
        //             fontWeight: FontWeight.normal),
        //       ),
        //     ),
        //     )
        //   )
      ],
    );
  });
}

AppBar buildAppBarEditProfile(context, String type, [PlatformFile? imagePath]) {
  if (type == "test") {
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
                .add(uploadingImageEvent(imageFile: imagePath));
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
        type,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal),
      ),
    );
  } else {
    return AppBar(
      // automaticallyImplyLeading: false,
      // leading: IconButton(
      //   icon: Icon(Icons.cancel_sharp),
      //   onPressed: () {},
      // ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withOpacity(0.5),
            height: 1.0,
          )),
      title: Text(
        type,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
