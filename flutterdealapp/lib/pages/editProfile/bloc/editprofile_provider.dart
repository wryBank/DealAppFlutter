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

  Future<void> editGender(String gender) async {
    try {
      await _fireCloud.doc(_uid).update({"gender": gender});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<void> updateCoin(String uid, double coin) async {
  //   final getOldCoin = FirebaseFirestore.instance
  //       .collection("users")
  //       .where("uid", isEqualTo: uid)
  //       .where("coin")
  //       .get();

  //   double calCoin = (getOldCoin as double) + coin;

  //   try {
  //     await _fireCloud.doc(_uid).update({"coin": calCoin});
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
  Future<double> updateCoin(String uid, double coin) async {
    try {
      // Await the result of the query
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(uid).get();
            

            

      // Check if documents are returned
          // print("querySnapshot.docs = ${querySnapshot.docs.first.data()}");
        // Assuming uid is unique, there should only be one document
        // final DocumentSnapshot<Map<String, dynamic>> document =
        //      querySnapshot.docs.first;
          // print("document = ${document.data()!["coin"]}");
        // final double oldCoin = document.data()?["coin"] ??
            // 0.0; // Safely try to convert to double, default to 0.0
          
        final double oldCoin = documentSnapshot.get("coin") ?? 0.0;
        print("oldCoin = $oldCoin");

        // Calculate the new coin value
        double calCoin = oldCoin + coin;

        print("oldCoin = $oldCoin");
        print("coin = $coin");
        print("calCoin = $calCoin");
        // Update the document with the new coin value
        await _fireCloud.doc(uid).update({"coin": calCoin});
        return calCoin;
        
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
