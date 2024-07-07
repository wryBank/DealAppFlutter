import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/main.dart';
import 'package:flutterdealapp/pages/Profile/profile.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/welcome/bloc/welcome_events.dart';
import 'package:flutterdealapp/values/color.dart';

import '../../service/shared_preferences_service.dart';
import 'bloc/welcome_blocs.dart';
import 'bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {

isLoggedin() async {
  print("inlog");
  ShardPreferencesService shardPreferencesService = ShardPreferencesService();
  String? value = await shardPreferencesService.readCache(key: 'email');
  
  Future.delayed(Duration(seconds: 1), () {
    if (value != null) {
      print("valussse: $value");
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => ApplicationPage()));
    } else{
      print("valussse: $value");
      
      
  }
  }
 
  );
}
// Future test() async {
//   print("test");
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("message received");
//     print("message data ${message.data}");
//     print(message.notification!.title);
//     print(message.notification!.body);
//     if (message.data['click_action'] == 'test') {
//       print("createPost-----------------------------------------------------------------------------------------------------------------------------------");
//       // MyApp.navigatorKey.currentState?.pushNamed('profile');
//       Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
//     }
//   });
// }

@override
  void initState() {
    // TODO: implement initState
    isLoggedin();
    // test();
    super.initState();
  }
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(body: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 34.h),
            width: 375.w,
            child: Stack(alignment: Alignment.topCenter, children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  state.page = index;
                  BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  print("index = ${index}");
                },
                children: [
                  _page(1, context, "next", "This is Deal", "Forw",
                      "assets/images/icon.png"),
                  _page(2, context, "next", "This is Deal", "Forw",
                      "assets/images/icon.png"),
                ],
              ),
              Positioned(
                bottom: 100.h,
                child: DotsIndicator(
                  position: state.page,
                  dotsCount: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: AppColors.primaryButton,
                    size: const Size.square(8.0),
                    activeSize: const Size(10.0, 8.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              )
            ]),
          );
        },
      )),
    );
  }
Widget _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(imagePath,fit: BoxFit.cover,),
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            subTitle,
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        GestureDetector(
          onTap: (){
            if(index<2){
              //animation
              _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
              

            }
            else{
              //jump to new page
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
              Navigator.of(context).pushNamedAndRemoveUntil("signIn", (route) => false);
              print("object");
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
                color:AppColors.primaryButton,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 10))
                ]
                ),
            child: Center(
              child: Text(
                "next",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        )
      ],
    );
  }
}