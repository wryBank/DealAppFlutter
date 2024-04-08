import 'package:flutter/cupertino.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_image.dart';

Widget buildPage(int index){
  List<Widget> _widgets = [
    Center(child: Text("home"),),
    EditProfile(),
    EditProfileimage(),
    Center(child: Text("home"),),
    Center(child: Text("home"),),
    
  ];
  return _widgets[index];

}