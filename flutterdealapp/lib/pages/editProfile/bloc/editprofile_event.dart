// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterdealapp/model/usermodel.dart';

@immutable
abstract class EditProfileEvent  {
}
class Create extends EditProfileEvent {
  // final String uid;
  // Create(this.uid);
  // final String uid;
  // final String username;
  // final int gender;
  // final String phonenumber;
  // final String urlprofileimage;
  // final String bio;
  // final int dealcount;
  // final int dealsucceed;
  // final int ondeal;
  // Create(this.uid,this.username,this.gender,this.phonenumber,this.urlprofileimage,this.bio,this.dealcount,this.dealsucceed,this.ondeal);
  
  UserModel userModel;
  Create({
    required this.userModel,
  });
}
// ignore: camel_case_types
class uploadingImageEvent extends EditProfileEvent{
  PlatformFile? imageFile;
  uploadingImageEvent({required this.imageFile});
}
class EditImageEvent extends EditProfileEvent{
  PlatformFile? imageFile;
  EditImageEvent({required this.imageFile});
}
