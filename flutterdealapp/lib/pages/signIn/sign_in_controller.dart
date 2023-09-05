import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/widgets/flutter_toast.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        // BlocProvider.of<SigninBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          toastInfo(msg: "You need fill email address");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "You need fill password");
          return;
        }
        try {
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);
          if (credential.user == null) {
            toastInfo(msg: "you don't exist");
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: "You need to verify your email account");
          }
          var user = credential.user;
          if (user != null) {
            // user verified from firebaske
            print("user not verified");
            if(user.emailVerified){
              print("user login");
              Navigator.of(context).pushNamed("Application");

            }
          } else {
            toastInfo(msg: "you not user of this app");
            // error getting user from firebase
          }
        } on FirebaseAuthException catch (e) {
            print("FirebaseAuthException: ${e.code}");
          if (e.code == 'user-not-found') {
            print("no user found for that email.");
            toastInfo(msg: "no user found for that email.");
          } else if (e.code == 'wrong-password') {
            toastInfo(msg: "Wrong password");
          } else if (e.code == 'invalid-email') {
            toastInfo(msg: "Your email format is wrong.");
          }
        }
      }
    } 
    catch (e) {
      print(e.toString());
    }
  }
}
