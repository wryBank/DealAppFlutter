
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/UserBloc/bloc/user_bloc.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/UserBloc/user_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/pages/welcome/bloc/welcome_blocs.dart';
import 'app/app_bloc.dart';
import 'editProfile/bloc/editprofile_provider.dart';
class AppBlocProviders{
  static get allBlocProviders=>[
    
    
        BlocProvider( create: (context) => WelcomeBloc(),),
        // BlocProvider( create: (context) => AppBloc(),),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => EditProfileBloc(editProfile_repo(provider: editProfile_provider()))),
        BlocProvider(create: (context) => UserBloc(user_repo(provider: user_provider()))),

  ];
  
}