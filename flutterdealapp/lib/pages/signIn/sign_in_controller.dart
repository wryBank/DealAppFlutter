import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/UserBloc/user_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/signIn/bloc/signin_blocs.dart';
import 'package:flutterdealapp/widgets/flutter_toast.dart';

import '../editProfile/bloc/editprofile_provider.dart';

class SignInController {
  final BuildContext context;
  // UserRepository userRepository = UserRepository();
  user_repo userRepository = user_repo(provider: user_provider());
  editProfile_repo _ediitprofile_repo = editProfile_repo(provider: editProfile_provider());
  UserModel userModel = UserModel();
  SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        // BlocProvider.of<SigninBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        
        userModel.email = emailAddress;
        userModel.uid = FirebaseAuth.instance.currentUser?.uid;
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
            return;
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: "You need to verify your email account");
            return;
          }
          var user = credential.user;
          userModel.uid = user!.uid;
          if (user != null && user.emailVerified) {
            // user verified from firebaske
            
            
            if(await userRepository.checkUser(user.uid)){
              print("user login");
              Navigator.of(context).pushNamed("Application");
              // Navigator.of(context).pushNamed("editprofileImage");
            }
            // else{
            //   print("adddata");
            //   userRepository.addData(userModel);
            //   // Navigator.of(context).pushNamed("editprofile");
            //   Navigator.of(context).pushNamed("editprofileImage");
            // }

            // if(user.emailVerified){
            //   print("user login");
            //   Navigator.of(context).pushNamed("Application");

            // }
            // else{
            //   _ediitprofile_repo.addData(userModel);
            //   Navigator.of(context).pushNamed("editprofile");
            // }
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
