import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/model/usermodel.dart';
import 'package:flutterdealapp/pages/register/bloc/register_blocs.dart';
import 'package:flutterdealapp/widgets/flutter_toast.dart';

import '../editProfile/bloc/editprofile_provider.dart';
import '../editProfile/bloc/editprofile_repo.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBloc>().state;
    editProfile_repo _ediitprofile_repo = editProfile_repo(provider: editProfile_provider());
    UserModel userModel = UserModel();
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;
    double coin = 0.0;
    userModel.dealcount = 0;
    userModel.dealsuccess = 0;
    userModel.coin = coin;
    userModel.email = email;
    userModel.username = userName;
    userModel.urlprofileimage = "https://firebasestorage.googleapis.com/v0/b/dealapp-363e7.appspot.com/o/files%2FdefaultProfile.png?alt=media&token=a025938a-fe31-4100-8601-c41169db88eb";
    

    if (userName.isEmpty) {
      toastInfo(msg: "User name can not be emty");
    }
    if (email.isEmpty) {
      toastInfo(msg: "email name can not be emty");
    }
    if (password.isEmpty) {
      toastInfo(msg: "password name can not be emty");
    }
    if (rePassword.isEmpty) {
      toastInfo(msg: "your password confirmation is wrong");
    }

    try {
      final creadential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
          userModel.uid = creadential.user!.uid;
      if (creadential.user != null) {
        creadential.user?.sendEmailVerification();
        creadential.user?.updateDisplayName(userName);
        _ediitprofile_repo.addData(userModel);

        toastInfo(
            msg:
                "An email has been send to your registered email. to activate it please check your email box and click on the link.");
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: "The email is already in use");
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: "You email is invalid");
      }
    }
  }
}
