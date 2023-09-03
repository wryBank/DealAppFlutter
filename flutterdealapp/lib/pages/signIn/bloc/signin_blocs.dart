import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_events.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState>{
  SignInBloc():super(const SignInState()){
    on<EmailEvent>(_emailEvent);


    on<passwordEvent>(_passwordEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit){
    print(event.email);
    emit(state.copyWith(email: event.email));
  }
  void _passwordEvent(passwordEvent event, Emitter<SignInState> emit){
    print(event.password);
    emit(state.copyWith(password: event.password));
  }
}