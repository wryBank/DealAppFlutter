
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});
  
  Future<void> handleSignIn(String type) async {
    try{
      if(type == "email"){
         //BlocProvider.of<SigninBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if(emailAddress.isEmpty){
          
        }
        else{
          print("email is $emailAddress");
        }
        if(password.isEmpty){

        }
        try{
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress, password: password);
          if(credential.user==null){

          }
          if(!credential.user!.emailVerified){
            
          }
          
          var user = credential.user;
          if(user!=null)
          {
            // user verified from firebase
            
          }
          else
          {
            // error getting user from firebase

          }

        }on FirebaseAuthException catch(e){
          if(e.code == 'user-not-found'){
            print("no user found for that email.");
          }
          else if (e.code == 'wrong-password'){
            print("Wrong password ");

          }
          else if(e.code=='invalid-email'){
            print("Your email format is wrong");
          }

        }
      }
    }
    catch(e){

    }
  }
}
