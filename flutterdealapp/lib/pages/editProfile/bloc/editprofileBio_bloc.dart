import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofileBio_state.dart';

class EditProfileBioBloc extends Bloc<BioEvent,BioState>{
  EditProfileBioBloc():super(const BioState()){
    on<BioEvent>(_bioEvent);

  }

  void _bioEvent(BioEvent event, Emitter<BioState> emit){
    print("bio = ${event.bio}");
    emit(state.copyWith(bio: event.bio));
    emit(BioState(bio: event.bio));
  }
}