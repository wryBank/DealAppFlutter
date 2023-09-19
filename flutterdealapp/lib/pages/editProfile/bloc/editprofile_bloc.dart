import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/repo/user_repo.dart';

class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileState>{
  final editProfile_repo repository;
  EditProfileBloc(this.repository) : super(InitialState()){
    on<Create>(((event, emit)async {
        print("inbloc");
        emit(LoadingState());
      try {
        print("inbloc");
        print("eventusermodel = ${event.userModel}");
        await  repository.editProfile(event.userModel);
        // emit(EditingData());
      } catch (e) {
        
      }
    }));
    on<uploadingImageEvent>((event, emit)async {
      try {
        await repository.uploadingImage(event.imageFile);
      } catch (e) {
        
      }
    });
}}
