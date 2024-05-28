import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/Profile/bloc/profile_bloc.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/register/bloc/register_event.dart';
import 'package:flutterdealapp/pages/register/bloc/register_state.dart';
import 'package:flutterdealapp/pages/register/register_controller.dart';

import '../../values/color.dart';
import '../common_widgets.dart';
import '../editProfile/bloc/editprofile_event.dart';
import '../editProfile/editprofile_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(getUserData(uid: FirebaseAuth.instance.currentUser!.uid));
  }
  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
    
      if (state is LoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is getDataState) {
        return Scaffold(
          appBar: 
    AppBar(
      // backgroundColor: Colors.blue,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryAppbar,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            // color: Colors.grey.withOpacity(0.5),
            // color: const Color.fromARGB(255, 0, 128, 255),
            height: 0.5,
          )),
      // title: Text(
      //   type,
      //   style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 16.sp,
      //       fontWeight: FontWeight.normal),
      // ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          color: Colors.white,
          onPressed: () {
            print("click edit");
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileimage()));
            // Navigator.popAndPushNamed(context, "editprofileimage");
            // MaterialPageRoute(builder: (context) => EditProfileimage());
          },
        )
      ],
    ),
          body: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.4,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.4 - 47,
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
                            child: Transform.scale(
                              scale: 1.2,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      // state.userModel!.urlprofileimage!),
                                      state.userModel!.urlprofileimage!),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text("${state.userModel!.username}",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                          Text("${state.userModel!.bio}",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
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
                                  vertical: 1,
                                ),
                                height: 70.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )]
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          state.userModel!.ondeal.toString(),
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.blue),
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
                                  vertical: 1,
                                ),
                                height: 70.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )]
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          state.userModel!.dealcount.toString(),
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.blue),
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
                                  vertical: 1,
                                ),
                                height: 70.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )]
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.blue),
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
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Builder(
                          builder: (context) {
                            return Material(
                              child: ListTile(
                                title: Text("test"),
                                subtitle: Text("test"),
                                leading: Icon(Icons.person),
                                trailing: Icon(Icons.edit),
                              ),
                            );
                          }
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }
      return Container();
    });

    // add gridview here
  }
}
