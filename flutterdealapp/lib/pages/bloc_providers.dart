
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/Profile/bloc/profile_bloc.dart';
import 'package:flutterdealapp/pages/UserBloc/bloc/user_bloc.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/UserBloc/user_repo.dart';
import 'package:flutterdealapp/pages/application/bloc/appBloc.dart';
import 'package:flutterdealapp/pages/createpost/bloc/createPost_bloc.dart';
import 'package:flutterdealapp/pages/createpost/createPost_provider.dart';
import 'package:flutterdealapp/pages/createpost/createPost_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/post/bloc/post_bloc.dart';
import 'package:flutterdealapp/pages/post/post_provider.dart';
import 'package:flutterdealapp/pages/post/post_repo.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/pages/welcome/bloc/welcome_blocs.dart';
import 'editProfile/bloc/editprofileGender_bloc.dart';
import 'editProfile/bloc/editprofile_provider.dart';
class AppBlocProviders{
  static get allBlocProviders=>[
    
    
        BlocProvider( create: (context) => WelcomeBloc(),),
        // BlocProvider( create: (context) => AppBloc(),),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => EditProfileBloc(editProfile_repo(provider: editProfile_provider()))),
        BlocProvider(create: (context) => UserBloc(user_repo(provider: user_provider()))),
        BlocProvider(create: (context) => ProfileBloc(user_repo(provider: user_provider()))),
        BlocProvider(create: (context) => EditProfileBioBloc()),
        BlocProvider(create: (context) => EditProfileGenderBloc()),
        BlocProvider(create: (context) => PostBloc(PostRepository(postProvider: PostProvider()))),
        BlocProvider(create: (context) => CreatePostBloc(CreatePostRepository(createPostProvider: CreatePostProvider()))),
        BlocProvider(create: (context) => LandingPageBloc()),

  ];
  
}