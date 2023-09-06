
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/pages/welcome/bloc/welcome_blocs.dart';
import 'app/app_bloc.dart';
class AppBlocProviders{
  static get allBlocProviders=>[
        BlocProvider( create: (context) => WelcomeBloc(),),
        // BlocProvider( create: (context) => AppBloc(),),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => EditProfileBloc())
  ];
  
}