// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/usermodel.dart';


@immutable
class EditProfileState  {
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
  final PlatformFile? imageFile2;
  EditImageState(this.imageFile2);
}
class showImageSelectState extends EditProfileState{
  final PlatformFile? imageFile;
  showImageSelectState(this.imageFile);
}
class uploadingImageState extends EditProfileState{
  final String? url;
  uploadingImageState(this.url);
}
class EditingData extends EditProfileState {
  UserModel userModel;
  EditingData({
    required this.userModel,
  });

}

