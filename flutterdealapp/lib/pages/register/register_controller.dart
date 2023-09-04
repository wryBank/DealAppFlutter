
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/widgets/flutter_toast.dart';

class RegisterController{
  final BuildContext context;
  const RegisterController({required this.context});


  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBloc>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if(userName.isEmpty){
      toastInfo(msg: "User name can not be emty");
    }
    if(email.isEmpty){
      toastInfo(msg: "email name can not be emty");
    }
    if(password.isEmpty){
      toastInfo(msg: "password name can not be emty");
    }
    if(rePassword.isEmpty){
      toastInfo(msg: "your password confirmation is wrong");
    }

    try{
      final creadential = await FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: email, password: password);
      if(creadential.user!=null){
        await creadential.user?.sendEmailVerification();
        await creadential.user?.updateDisplayName(userName);
        toastInfo(msg: "An email has been send to your registered email. to activate it please check your email box and click on the link.");
        Navigator.of(context).pop();
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        toastInfo(msg: "The password provided is too weak");
      }else if(e.code == 'email-already-in-use'){
        toastInfo(msg: "The email is already in use");
      }else if(e.code == 'invalid-email'){
        toastInfo(msg: "You email is invalid");
        
      }

    }

  }
}