import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdealapp/model/usermodel.dart';
class UserRepository{
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  

  Future<void> create(UserModel userModel) async{
    try{
      print("inproviver");
    final _fireCloud = FirebaseFirestore.instance.collection("users").doc(_uid);
      await _fireCloud.set(userModel.toMap()
        );
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
  }

}