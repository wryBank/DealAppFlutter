import 'package:flutter/cupertino.dart';
import 'package:flutterdealapp/pages/Feed/Feed_page.dart';
import 'package:flutterdealapp/pages/application/test.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_image.dart';
import 'package:flutterdealapp/pages/Profile/profile.dart';

Widget buildPage(int index){
  List<Widget> _widgets = [
    FeedPage(),
    // test(),
    test(),
    ProfilePage(),
    Center(child: Text("home"),),
    Center(child: Text("home"),),
    
  ];
  return _widgets[index];

}