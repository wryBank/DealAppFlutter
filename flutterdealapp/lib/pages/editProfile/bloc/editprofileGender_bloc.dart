import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileGender_state.dart';

import 'editprofileGender_event.dart';

class EditProfileGenderBloc extends Bloc<GenderEvent,GenderState>{
  EditProfileGenderBloc():super(const GenderState()){
    on<GenderEvent>(_genderEvent);

  }

  void _genderEvent(GenderEvent event, Emitter<GenderState> emit){
    print("gender = ${event.Gender}");
    emit(state.copyWith(Gender: event.Gender));
    emit(GenderState(Gender: event.Gender));
  }
}