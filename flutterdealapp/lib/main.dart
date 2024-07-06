import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/firebase/PushNotificationService.dart';
import 'package:flutterdealapp/firebase/firebaseApi.dart';
import 'package:flutterdealapp/pages/Feed/Feed_page.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/bloc_providers.dart';
import 'package:flutterdealapp/pages/Profile/profile.dart';
import 'package:flutterdealapp/pages/register/register.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/pages/signIn/sign_in.dart';
import 'package:flutterdealapp/pages/welcome/bloc/welcome_blocs.dart';
import 'package:flutterdealapp/pages/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterdealapp/service/shared_preferences_service.dart';
import 'package:flutterdealapp/values/color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

import 'pages/editProfile/editprofile_image.dart';

// sendData()async {
//   // print('sendDatasssss');
//       await Geolocator.checkPermission();
//     await Geolocator.getCurrentPosition();
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   print("Latitude: ${position.latitude} Longitude: ${position.longitude}");
// }
Future<void> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  print("Latitude: ${position.latitude} Longitude: ${position.longitude}");
}

Future<void> getPermission() async {
  // await Permission.location.request();
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  //  await Permission.locationAlways.request();
}

const task = 'getLocation';
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    DartPluginRegistrant.ensureInitialized();
    // print("Native called background task: $task");
    switch (taskName) {
      case 'getLocation':
        await getLocation();

        break;
      default:
    }
    return Future.value(true);
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseApi().initNotification();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("message received");
    print("message data ${message.data}");
    print(message.notification!.title);
    print(message.notification!.body);
  });
  // String? token = await FirebaseMessaging.instance.getToken();
  // print("token: $token ");
  runApp(const MyApp());
}
// Future<void> requestPermission() async {
//   var status = await Permission.location.request();
//   if (status.isGranted) {
//     // Permission is granted, proceed with the location-related task
//   } else if (status.isDenied) {
//     // Permission is denied, handle appropriately
//   } else if (status.isPermanentlyDenied) {
//     // The user opted to never again see the permission request dialog for this
//     // app. The only way to change the permission's status now is to let the
//     // user manually enable it in the system settings.
//     openAppSettings();
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    getPermission();
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      appBarTheme: const AppBarTheme(
                          iconTheme:
                              IconThemeData(color: AppColors.primaryText),
                          elevation: 0,
                          backgroundColor: Colors.white)),
                  home: Welcome(),
                  routes: {
                    // "MyHomePage": (context) => const MyHomePage(),
                    "signIn": (context) => const SignIn(),
                    "register": (context) => const Register(),
                    "profile": (context) => const ProfilePage(),
                    "Application": (context) => const ApplicationPage(),
                    "editprofileImage": (context) => const EditProfileimage(),
                    "Feed": (context) => const FeedPage(),
                  })),
    );
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: ElevatedButton(
    //         onPressed: () async {
    //           // requestPermission();
    //           // var  date =DateTime.now().second.toString();
    //           // await Workmanager().registerOneOffTask(date, task,
    //           // initialDelay: Duration(seconds: 10),
    //           // constraints: Constraints(networkType: NetworkType.connected)
    //           // );
    //           PushNotificationService.sendNotificationToUser(
    //               "dRWr9lk9TLOnvF0Hx-NN4J:APA91bGvMGQlbOe2tpW4F_niV-sZMmAA15tVOqJJIVsNSVzBWRBdwTo1V0N4BAOB1fLlhBmA4rdiTK7tNmZG5iNCOS_nHO1xiM0dq2Uq-K2f7mdSx4uW87WawcZHluBG3v-WllzJXve0",
    //               context,);
    //         },
    //         child: Text('Welcome to FlutterDealApp'),
    //       ),
    //     ),
    //   ),
    // );
  }
}
