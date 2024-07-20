import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/application/bloc/appEvent.dart';
import 'package:flutterdealapp/pages/application/bloc/appState.dart';

class LandingPageBloc extends Bloc<AppEvent, LandingPageState> {
  LandingPageBloc() : super(const LandingPageInitial(tabIndex: 0)) {
    on<AppEvent>((event, emit) {
      if (event is TapChange) {
        print(event.tabIndex);
        emit(LandingPageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
