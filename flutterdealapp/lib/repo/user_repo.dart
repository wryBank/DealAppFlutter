import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class UserRepository{
  final _fireCloud = FirebaseFirestore.instance.collection("users");
  

  Future<void> create({required String uid,required String username, required int gender, required String phonenumber,required String urlprofileimage, 
  required String bio ,required int dealcount, required int dealsucceed , required int ondeal }) async{
    try{
      await _fireCloud.add({
        "uid":uid,
        "username":username,
        "gender":gender,
        "phonenumber":phonenumber,
        "urlprofileimage":urlprofileimage,
        "bio":bio,
        "dealcount":dealcount,
        "dealsucceed":dealsucceed,
        "ondeal":ondeal
      }
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