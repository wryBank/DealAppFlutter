import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdealapp/model/usermodel.dart';
class UserRepository{
  final _fireCloud = FirebaseFirestore.instance.collection("users");
  

  Future<void> create(UserModel userModel) async{
    try{
      await _fireCloud.add(userModel.toMap()
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