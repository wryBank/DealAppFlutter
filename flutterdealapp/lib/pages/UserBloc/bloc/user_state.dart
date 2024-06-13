// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/usermodel.dart';


@immutable
class UserState  {
}

class InitialState extends UserState{

}
class LoadingState extends UserState{
}
class EditingError extends UserState{
  final String message;
  EditingError(this.message); 
}

class getDataState extends UserState{
  final String? uid;
  getDataState(this.uid);
}
class getProfileImageState extends UserState{
  final String? url;
  getProfileImageState(this.url);
}
class getUserByUidState extends UserState{
  final UserModel userModel;
  getUserByUidState(this.userModel);
}



