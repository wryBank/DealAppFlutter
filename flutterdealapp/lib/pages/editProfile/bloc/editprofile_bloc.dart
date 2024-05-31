import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';

import '../../../model/usermodel.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final editProfile_repo repository;
  EditProfileBloc(this.repository) : super(InitialState()) {
    on<InitialEvent>((event, emit) {
      // Potentially perform initial logic here (empty for now)
    }); // Add this handler
    on<EditImageEvent>((event, emit) async {
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        print("in editimageevent");
        print("uiddddd = ${event.uid}");
        repository.getUserData(event.uid!);
        UserModel userModel = await repository.provider.getUserData(event.uid!);
        print("usermodel naja $userModel");
        emit(EditImageState(userModel));
        // return;
      } catch (e) {}
    });

    on<uploadingImageEvent>((event, emit) async {
      emit(LoadingState());
      try {
        print("in bloc uploadimage");
        print("wwwwaaaa${repository.uploadingImage(event.imageFile)}");
        print(" wwwwww ${event.imageFile!.path}");
        String? url = await repository.provider.uploadImage(event.imageFile);
        print("url = ${url}");
        emit(doneUploadState(url));
        // emit(EditProfileState());
        // emit(uploadingImageState(url));
      } catch (e) {}
    });
    on<showImageSelect>((event, emit) async {
      emit(LoadingState());
      try {
        print("in bloc uploadimage");
        // print("wwwwaaaa${repository.uploadingImage(event.imageFile)}");
        // await repository.uploadingImage(event.imageFile);
        // print(" wwwwww ${event.imageFile!.path}");
        emit(showImageSelectState(event.imageFile));
      } catch (e) {}
    });
    on<showData>((event, emit) async {
      emit(LoadingState());
      try {
        print("in editprofileevent");
        print("uiddddd = ${event.userModel.uid}");
        repository.editProfile(event.userModel);
        UserModel userModel = await repository.provider.getUserData(event.userModel.uid!);
        emit(EditProfileState(userModelProfile: userModel));
      } catch (e) {}
    });
  on<updateProfileBioEvent>((event, emit) async {
      emit(LoadingState());
      try {
        print("in editprofileevent");
        print("bio = ${event.bio}");
        repository.editBio(event.bio);
        UserModel userModel = await repository.provider.getUserData(FirebaseAuth.instance.currentUser!.uid);
        emit(updateProfileBioState(userModel.bio!));
        print("emit bio = ${userModel.bio}");
      } catch (e) {}
    });
    on<EditingBioEvent>((event, emit)  {
        print("in editprofileevent");
        print("bio = ${event.bio}");
        // emit(state.bio);
    });
  }
  }
  
