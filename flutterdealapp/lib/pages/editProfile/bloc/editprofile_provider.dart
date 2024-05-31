import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../model/usermodel.dart';

class editProfile_provider {
  final _fireCloud = FirebaseFirestore.instance.collection("users");
  final _firefirestore = FirebaseFirestore.instance;
  final _firestore = FirebaseStorage.instance;
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  PlatformFile? pickedFile;

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
  // check user is exit or not
  Future<bool> checkUser(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(id).get();
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
Future<void> editBio(String bio) async {
  try {
    await _fireCloud.doc(_uid).update({"bio": bio});
  } catch (e) {
    throw Exception(e.toString());
  }
}

}
