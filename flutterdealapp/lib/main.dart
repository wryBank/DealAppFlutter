import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/Feed/Feed_page.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/bloc_providers.dart';
import 'package:flutterdealapp/pages/Profile/profile.dart';
import 'package:flutterdealapp/pages/register/register.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/pages/signIn/sign_in.dart';
import 'package:flutterdealapp/pages/welcome/bloc/welcome_blocs.dart';
import 'package:flutterdealapp/pages/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterdealapp/values/color.dart';

import 'pages/editProfile/editprofile_image.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      appBarTheme: const AppBarTheme(
                          iconTheme: IconThemeData(
                            color: AppColors.primaryText
                          ),
                          elevation: 0, backgroundColor: Colors.white)),
                  home: Welcome(),
                  routes: {
                    // "MyHomePage": (context) => const MyHomePage(),
                    "signIn": (context) => const SignIn(),
                    "register":(context) => const Register(),
                    "profile":(context) => const ProfilePage(),
                    "Application":(context) => const ApplicationPage(),
                    "editprofileImage":(context) => const EditProfileimage(),
                    "Feed":(context) => const FeedPage(),
                  })),
    );
  }
}