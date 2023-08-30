
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc():super(InitStates()){
    on<Increment>((event,emit){
      print("instate");
      emit(AppState(counter: state.counter+1));
    });
    
    on<Decrement>((event, emit) {
      print("decre");
      
    },);
    
  }

}
