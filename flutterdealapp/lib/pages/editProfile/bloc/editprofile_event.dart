import 'package:flutter/material.dart';

@immutable
abstract class EditProfileEvent  {
  
}
class Create extends EditProfileEvent{
  final String uid;
  final String username;
  final int gender;
  final String phonenumber;
  final String urlprofileimage;
  final String bio;
  final int dealcount;
  final int dealsucceed;
  final int ondeal;
  Create(this.uid,this.username,this.gender,this.phonenumber,this.urlprofileimage,this.bio,this.dealcount,this.dealsucceed,this.ondeal);
}