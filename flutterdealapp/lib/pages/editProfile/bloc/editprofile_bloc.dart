

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/repo/user_repo.dart';

class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileState>{
  EditProfileBloc() : super(InitialState()){
    on<Create>((event, emit) async {
    });
  } 
}
