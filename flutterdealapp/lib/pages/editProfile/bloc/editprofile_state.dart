
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
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
class EditingData extends EditProfileState{
  final String uid;
  final String username;
  final int gender;
  final String phonenumber;
  final String urlprofileimage;
  final String bio;
  final int dealcount;
  final int dealsucceed;
  final int ondeal;
  EditingData(this.uid, this.username, this.gender, this.phonenumber, this.urlprofileimage, this.bio, this.dealcount, this.dealsucceed, this.ondeal);
}