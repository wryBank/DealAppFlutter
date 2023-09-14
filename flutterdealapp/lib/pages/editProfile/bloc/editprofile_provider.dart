
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../model/usermodel.dart';

class editProfile_provider{
  
  final _fireCloud = FirebaseFirestore.instance.collection("users");
  final _firefirestore = FirebaseFirestore.instance;
  final _firestore = FirebaseStorage.instance;
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  PlatformFile? pickedFile;

  Future<void> editProfile(UserModel userModel) async{
    try{
      print("inprovicer");
      print("uid = "+_uid!);
      await _fireCloud.doc(_uid).update(userModel.toMap());
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
  }
  Future<void> addData(UserModel userModel) async{
    try{
      // await _fireCloud.add(userModel.toMap());
      await _fireCloud.doc(_uid).set(userModel.toMap());
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
  }
  // delete data firebase code
  Future<void> deleteData(String id) async{
    try{
      await _fireCloud.doc(id).delete();
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
  }
  // get data firebase code
  Future<List<UserModel>> getData() async{
    try{
      QuerySnapshot querySnapshot = await _fireCloud.get();
     return querySnapshot.docs.map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
    return [];
  }
  // get image firebase
  Future<String> getImage(String id) async{
    try{
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(id).get();
      return documentSnapshot.get("urlprofileimage");
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
    return "";
  }
  // upload image firebase
  Future<String?> uploadImage(PlatformFile? pickedFile) async{
    try{
      pickedFile = (await FilePicker.platform.pickFiles(type: FileType.image)) as PlatformFile?;
      if(pickedFile != null){
        String fileName = pickedFile.name;
        String filePath = pickedFile.path!;
        String? result = await _firestore.ref().child("images/$fileName").putFile(Uri.parse(filePath) as File).then((value) => value.ref.getDownloadURL());
        return result;
      }
    } on FirebaseException catch(e){
      if(kDebugMode){
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e){
      throw Exception(e.toString());
    }
    return "";
  }
  

}