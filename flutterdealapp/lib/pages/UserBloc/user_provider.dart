import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../model/usermodel.dart';
import '../../firebase/PushNotificationService.dart';

class user_provider {
  final _fireCloud = FirebaseFirestore.instance.collection("users");
  final _firefirestore = FirebaseFirestore.instance;
  final _firestore = FirebaseStorage.instance;
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  PlatformFile? pickedFile;

  Future<void> addUserToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("token:--------------- $token ");
    try {
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(_uid).get();
      if (documentSnapshot.exists) {
        await _fireCloud.doc(_uid).update({"userToken": token});
      } else {
        print("user not exist");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateLocation(double latitude, double longitude) async {
    print("inprovider updateLocation");
    try {
      await _fireCloud
          .doc(_uid)
          .update({"lastLatitude": latitude, "lastLongitude": longitude});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> editProfile(UserModel userModel) async {
    try {
      print("inprovicer");
      print("uid = " + _uid!);
      await _fireCloud.doc(_uid).update(userModel.toMap());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addData(UserModel userModel) async {
    try {
      // await _fireCloud.add(userModel.toMap());
      await _fireCloud.doc(userModel.uid).set(userModel.toMap());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // delete data firebase code
  Future<void> deleteData(String id) async {
    try {
      await _fireCloud.doc(id).delete();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // get data firebase code
  Future<List<UserModel>> getData() async {
    try {
      QuerySnapshot querySnapshot = await _fireCloud.get();
      return querySnapshot.docs
          .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return [];
  }
  
  Future<String> getToken (String uid)async{
    String token = "";
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(uid).get();
      token = documentSnapshot.get("userToken").toString();
 
    return token;
  }

  // check user is exit or not
  Future<bool> checkUser(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(id).get();

      String? token = await FirebaseMessaging.instance.getToken();
      await _fireCloud.doc(id).update({"userToken": token});
      return documentSnapshot.exists;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return false;
  }

  // get image firebase
  Future<String> getImage(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(id).get();
      return documentSnapshot.get("urlprofileimage");
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return "";
  }

  Future<String?> EditImage(PlatformFile? pickedFile) async {
    try {
      pickedFile = (await FilePicker.platform.pickFiles(type: FileType.image))
          as PlatformFile?;
      return pickedFile?.path.toString();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // upload image firebase
  Future<String?> uploadImage(PlatformFile? pickedFile) async {
    print("inprovider uploadimage");
    UploadTask? uploadTask;
    String urlDownload = '';
    try {
      print("intry");
      // pickedFile = (await FilePicker.platform.pickFiles(type: FileType.image)) as PlatformFile?;
      // // if(pickedFile != null){
      //   String? fileName = pickedFile?.name;
      //   String? filePath = pickedFile?.path;
      //   String? result = await _firestore.ref().child("images/$fileName").putFile(Uri.parse(filePath!) as File).then((value) => value.ref.getDownloadURL());
      //   print("${result} result");
      //   return result;
      // // }
      final path = 'files/${pickedFile?.name}';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      urlDownload = await snapshot.ref.getDownloadURL();
      uploadUrl(urlDownload);
      return urlDownload;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return "";
  }

// uploadUrl image to firebase doc
  Future<void> uploadUrl(String url) async {
    try {
      await _fireCloud.doc(_uid).update({"urlprofileimage": url});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

// get userdata by uid
  Future<UserModel> getUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(uid).get();
      return UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    }
    throw Exception("Failed to get user data."); // Added throw statement
  }
}
