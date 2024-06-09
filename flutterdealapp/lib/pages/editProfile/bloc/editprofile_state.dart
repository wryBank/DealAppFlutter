// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/usermodel.dart';


@immutable
class EditProfileState  {
  UserModel? userModelProfile;
  EditProfileState({this.userModelProfile});
 

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
  UserModel? userModel;
  EditImageState(this.userModel);
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
class doneUploadState extends EditProfileState {
  final String? url;
  doneUploadState(this.url);
}
class updateProfileBioState extends EditProfileState{
  final String? bio;
  updateProfileBioState(this.bio);
}
class updateProfileGenderState extends EditProfileState{
  final String? Gender;
  updateProfileGenderState(this.Gender);
}
class showDataState extends EditProfileState{
  String? uid;
  showDataState(this.uid);
}
class EditingBio extends EditProfileState{
  final String bio;
  EditingBio(this.bio);
}