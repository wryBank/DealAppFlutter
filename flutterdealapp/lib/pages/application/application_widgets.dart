import 'package:flutter/cupertino.dart';

Widget buildPage(int index){
  List<Widget> _widgets = [
    Center(child: Text("home"),),
    Center(child: Text("home2"),),
    Center(child: Text("home"),),
    Center(child: Text("home"),),
    Center(child: Text("home"),),
    
  ];
  return _widgets[index];

}