// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../model/usermodel.dart';


abstract class EditProfileState {
}
class InitialState extends EditProfileState{

}
class LoadingState extends EditProfileState{
}
class EditingError extends EditProfileState{
  final String message;
  EditingError(this.message); 
}
class EditImageState extends EditProfileState{
  final PlatformFile? imageFile;
  EditImageState(this.imageFile);
}
class uploadingImageState extends EditProfileState{
  final String? url;
  uploadingImageState(this.url);
}
class EditingData extends EditProfileState {
  // final String uid;
  // EditingData(this.uid);
  // final String username;
  // final int gender;
  // final String phonenumber;
  // final String urlprofileimage;
  // final String bio;
  // final int dealcount;
  // final int dealsucceed;
  // final int ondeal;
  // EditingData(this.uid, this.username, this.gender, this.phonenumber, this.urlprofileimage, this.bio, this.dealcount, this.dealsucceed, this.ondeal);
  UserModel userModel;
  EditingData({
    required this.userModel,
  });
}
