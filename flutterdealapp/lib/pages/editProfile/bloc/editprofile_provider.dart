import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../model/usermodel.dart';

class editProfile_provider{
  
  final _fireCloud = FirebaseFirestore.instance.collection("users");
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  Future<void> editProfile(UserModel userModel) async{
    try{
      print("inprovicer");
      print("uid = "+_uid);
      await _fireCloud.doc(_uid).update(userModel.toMap());
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
  }

}