import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterdealapp/pages/UserBloc/bloc/user_state.dart';
import 'package:flutterdealapp/pages/UserBloc/user_repo.dart';

import '../../../model/usermodel.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final user_repo repository;
  UserBloc(this.repository) : super(UserState()) {
    on<getUser>((event, emit) async {
      try {
        print("inbloc");
        emit(LoadingState());
        print("eventusermodel = ${event.userModel}");
         repository.getUserData(event.userModel.uid!);
         UserModel userModel = await repository.provider.getUserData(event.userModel.uid!);
        String? url = userModel.urlprofileimage;
        emit(getProfileImageState(url));
      } catch (e) {}
    });
    on<getUserByUid>((event, emit) async {
      try {
        print("inbloc userbyid");
        emit(LoadingState());
        print("eventusermodel = ${event.uid}");
         repository.getUserData(event.uid);
         UserModel userModel = await repository.provider.getUserData(event.uid);
        emit(getUserByUidState(userModel));
      } catch (e) {}
    });
  }
}
