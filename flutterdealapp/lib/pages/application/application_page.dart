import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdealapp/pages/application/bloc/appBloc.dart';
import 'package:flutterdealapp/pages/application/bloc/appEvent.dart';
import 'package:flutterdealapp/pages/application/bloc/appState.dart';
import 'package:geolocator/geolocator.dart';

import 'package:firebase_core/firebase_core.dart';
import '../UserBloc/user_provider.dart';
import '../editProfile/bloc/editprofile_bloc.dart';
import '../editProfile/bloc/editprofile_event.dart';
import 'application_widgets.dart';

class ApplicationPage extends StatefulWidget {
  final int initialIndex;
  const ApplicationPage({this.initialIndex = 0});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  Future multipleRegistration() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.instance.subscribeToTopic("myTopic1");
  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
  }
  // ...

  Timer? _timer;
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    getLocation();
    // _index = widget.initialIndex;
    // getLocation()
    // _timer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   getLocation();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
                  // backgroundColor: Colors.red,
                  body: buildPage(state.tabIndex),
                  bottomNavigationBar: NavigationBar(
                    backgroundColor: Color.fromRGBO(161, 196, 253, 50),
                    height: 65,
                    elevation: 0,
                    destinations: [
                      NavigationDestination(
                        icon: SizedBox(
                          width: 25.w,
                          height: 25.h,
                          child: Image.asset(
                            "assets/images/newFeed.png",
                          ),
                        ),
                        label: "Home",
                      ),
                      NavigationDestination(
                        // icon: Icon(Icons.search),
                        icon: SizedBox(
                          width: 25.w,
                          height: 25.h,
                          child: Image.asset(
                            "assets/images/icon.png",
                          ),
                        ),
                        label: "Search",
                      ),
                      NavigationDestination(
                        icon: SizedBox(
                          width: 25.w,
                          height: 25.h,
                          child: Image.asset(
                            "assets/images/wallet.png",
                          ),
                        ),
                        label: "Wallet",
                      ),
                      NavigationDestination(
                        // icon: Icon(Icons.person),
                        icon: SizedBox(
                          width: 25.w,
                          height: 25.h,
                          child: Image.asset(
                            "assets/images/defaultProfile.png",
                          ),
                        ),
                        label: "Profile",
                      ),
                    ],
                    selectedIndex: state.tabIndex,
                    onDestinationSelected: (index) {
                      BlocProvider.of<LandingPageBloc>(context)
                          .add(TapChange(tabIndex: index));
                    },
                  )
                  // bottomNavigationBar: Container(
                  //   child: BottomNavigationBar(
                  //     // backgroundColor: Colors.red,
                  //     // onTap: (value) {
                  //     //   setState(() {
                  //     //     _index = value;
                  //     //   });
                  //     //   if (value == 2) {
                  //     //     // BlocProvider.of<EditProfileBloc>(context)
                  //     //     //     .add(EditImageEvent(userModel: UserModel()));
                  //     //   }
                  //     // },
                  //     elevation: 0,
                  //     items: [
                  //       BottomNavigationBarItem(

                  //           label: "a",
                  //           icon: SizedBox(
                  //             width: 35.w,
                  //             height: 35.h,
                  //             child: Image.asset("assets/images/newFeed.png"),
                  //           )),
                  //       BottomNavigationBarItem(
                  //           label: "a",
                  //           icon: SizedBox(
                  //             width: 35.w,
                  //             height: 35.h,
                  //             child: Image.asset("assets/images/icon.png"),
                  //           )),
                  //       BottomNavigationBarItem(
                  //           label: "a",
                  //           icon: SizedBox(
                  //             width: 35.w,
                  //             height: 35.h,
                  //             child: Image.asset("assets/images/wallet.png"),
                  //           )),
                  //       BottomNavigationBarItem(
                  //           label: "a",
                  //           icon: Container(
                  //             child: SizedBox(
                  //               width: 35.w,
                  //               height: 35.h,
                  //               child: Image.asset(
                  //                   "assets/images/defaultProfile.png"),
                  //             ),
                  //           )),
                  //     ],
                  //     // backgroundColor: Colors.black,
                  //     currentIndex: state.tabIndex,
                  //     // selectedItemColor: Colors.blue.shade800,
                  //     onTap: (value) {
                  //       BlocProvider.of<LandingPageBloc>(context)
                  //           .add(TapChange(tabIndex: value));
                  //     },
                  //   ),
                  // )
                  ));
        });
  }
}
