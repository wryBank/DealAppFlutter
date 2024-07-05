import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdealapp/pages/UserBloc/bloc/user_bloc.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_provider.dart';

import '../../../model/usermodel.dart';

class user_repo{
  final user_provider provider;
  user_repo({required this.provider});

  Future<void> editProfile(UserModel userModel) async{
      print("inrepo");
    await provider.editProfile(userModel);
  }
  Future<void> addUserToken() async{
    await provider.addUserToken();
  }
  Future<void> addData(UserModel userModel) async{
    await provider.addData(userModel);
  }
  Future<void> uploadingImage(PlatformFile? imageFile) async{
    print("inrepo uploadimage");
    await provider.uploadImage(imageFile);
  }
  Future<void> EditImage(PlatformFile? imageFile) async{
    print("inrepo uploadEditimage");
    await provider.EditImage(imageFile);
  }
  Future<bool> checkUser(String uid) async{
    print("inrepo checkuser");
    return await provider.checkUser(uid);
  }
  Future<void> upLoadUrlImage(String url) async{
    print("inrepo uploadurlimage");
    await provider.uploadUrl(url);
  }
  Future<void> getUserData(String uid) async{
    print("inrepo getdata");
    await provider.getUserData(uid);
  }
}
