import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_provider.dart';

import '../../../model/usermodel.dart';

class editProfile_repo{
  final editProfile_provider provider;
  editProfile_repo({required this.provider});

  Future<void> editProfile(UserModel userModel) async{
      print("inrepo");
    await provider.editProfile(userModel);
  }
  Future<void> addData(UserModel userModel) async{
    await provider.addData(userModel);
  }
  Future<void> uploadingImage(PlatformFile? imageFile) async{
    await provider.uploadImage(imageFile);
  }
}
