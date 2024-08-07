import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_provider.dart';

import '../../../model/usermodel.dart';

class editProfile_repo {
  final editProfile_provider provider;
  editProfile_repo({required this.provider});

  Future<void> editProfile(UserModel userModel) async {
    print("inrepo");
    await provider.editProfile(userModel);
  }

  Future<void> addData(UserModel userModel) async {
    await provider.addData(userModel);
  }

  Future<void> uploadingImage(PlatformFile? imageFile) async {
    print("inrepo uploadimage");
    await provider.uploadImage(imageFile);
  }

  Future<void> EditImage(PlatformFile? imageFile) async {
    print("inrepo uploadEditimage");
    await provider.EditImage(imageFile);
  }

  Future<bool> checkUser(String uid) async {
    print("inrepo checkuser");
    return await provider.checkUser(uid);
  }

  Future<void> upLoadUrlImage(String url) async {
    print("inrepo uploadurlimage");
    await provider.uploadUrl(url);
  }

  Future<void> getUserData(String uid) async {
    print("inrepo getdata");
    await provider.getUserData(uid);
  }

  Future<void> editBio(String bio) async {
    print("inrepo editbio");
    await provider.editBio(bio);
  }

  Future<void> editGender(String gender) async {
    print("inrepo editbio");
    await provider.editGender(gender);
  }

  Future<double> updateCoin(String uid, double coin) async {
    print("inrepo editbio");
    return await provider.updateCoin(uid, coin);
  }
}
