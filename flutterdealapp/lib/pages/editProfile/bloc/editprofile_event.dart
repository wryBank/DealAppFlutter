// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterdealapp/model/usermodel.dart';
import 'package:image_picker/image_picker.dart';

@immutable
abstract class EditProfileEvent  {
  const EditProfileEvent();
}
class InitialEvent extends EditProfileEvent{
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
  // uploadingImageEvent({required this.imageFile, required PlatformFile url});
  uploadingImageEvent({required this.imageFile});
}
class EditImageEvent extends EditProfileEvent{
  String? uid ;
  EditImageEvent({required this.uid});
}
class UploadUrlImageEvent extends EditProfileEvent{
  String url;
  UploadUrlImageEvent({required this.url});
}
class showImageSelect extends EditProfileEvent{
  PlatformFile? imageFile;
  showImageSelect({required this.imageFile});
}
class showData extends EditProfileEvent{
  UserModel userModel;
  showData({
    required this.userModel,
  });
}
class updateProfileBioEvent extends EditProfileEvent{
  String bio;
  updateProfileBioEvent(this.bio);
}
class updateProfileGenderEvent extends EditProfileEvent{
  String Gender;
  updateProfileGenderEvent(this.Gender);
}
class EditingBioEvent extends EditProfileEvent{
  String bio;
  EditingBioEvent(this.bio);
}
class updateCoinEvent extends EditProfileEvent{
  String uid;
  double coin;
  updateCoinEvent(this.uid,this.coin);
}
