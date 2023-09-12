import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_provider.dart';

import '../../../model/usermodel.dart';

class editProfile_repo{
  final editProfile_provider provider;
  editProfile_repo({required this.provider});

  Future<void> editProfile(UserModel userModel) async{
      print("inrepo");
    await provider.editProfile(userModel);
    
  }
<<<<<<< HEAD
  Future<void> addData(UserModel userModel) async{
    await provider.addData(userModel);
  }
=======
>>>>>>> d52c081fdceb3d0edf2dbc66e571d15c8ce2eef0

}
