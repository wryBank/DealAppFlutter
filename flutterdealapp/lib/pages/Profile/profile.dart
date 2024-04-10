import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';

import '../common_widgets.dart';
import '../editProfile/bloc/editprofile_event.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.4,
          child: Stack(
            children: <Widget>[
              Container(
                  height: size.height * 0.4 -47,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 88, 172, 255),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/images/icon.png"),
                        ),
                      ),
                      Text("test"),
                      Text("test")
                    ],
                  ),
                  ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(
                            vertical:1,
                          ),
                          height: 70.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white),
                                  ),
                                  Expanded(
                                      child: Image.asset(
                                    "assets/images/icon.png",
                                    fit: BoxFit.cover,
                                  ))
                                ],
                              ),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          height: 70.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white),
                                  ),
                                  Expanded(
                                      child: Image.asset(
                                    "assets/images/icon.png",
                                    fit: BoxFit.cover,
                                  ))
                                ],
                              ),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          height: 70.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white),
                                  ),
                                  Expanded(
                                      child: Image.asset(
                                    "assets/images/icon.png",
                                    fit: BoxFit.cover,
                                  ))
                                ],
                              ),
                            ],
                          )),
                    ]),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("test"),
                subtitle: Text("test"),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.edit),
              );
            }
          ),
        ),
        
      ],
    );
    // add gridview here

  }
}
