import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/UserBloc/user_repo.dart';

import '../../../model/usermodel.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final user_repo repository;
  ProfileBloc(this.repository) : super(InitialState()) {
    on<getUserData>((event, emit) async{
      try {
        print("inbloc profile");
        emit(LoadingState());
        print("evet get userdata = ${event.uid}");
        //  repository.getUserData(event.uid!);
         UserModel userModel = await repository.provider.getUserData(event.uid!);
        emit(getDataState(userModel));
      } catch (e) {}
      
      // TODO: implement event handler
    });
  }
}
