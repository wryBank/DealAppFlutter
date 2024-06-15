import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdealapp/model/postmodel.dart';

import '../../model/usermodel.dart';

class CreatePostProvider {
  final _fireCloudUser = FirebaseFirestore.instance.collection("users");
  final _fireCloudPost = FirebaseFirestore.instance.collection("posts");
  final _firefirestore = FirebaseFirestore.instance;
  final _firestore = FirebaseStorage.instance;
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  PlatformFile? imageFile;

  Future<void> createPost(PostModel postModel) async {
    try {
      print("inprovicer");
      print("uid = " + _uid!);

      // await _fireCloudPost.add(postModel.toMap()).then((DocumentReference docRef) {
      //   docRef.update({'pid': docRef.id});
      DocumentReference<PostModel> docRef = await _fireCloudPost
          // final postColl = FirebaseFirestore.instance
          // .collection('posts')
          .withConverter<PostModel>(
            fromFirestore: (snapshot, _) =>
                PostModel.fromJson(snapshot.data()!),
            toFirestore: (post, _) => post.toJson(),
          )
          .add(postModel);
      await docRef.update({'pid': docRef.id});

      // });
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> imageToFirebase(PlatformFile imageFile) async {
    UploadTask? uploadTask;
    String urlDownload = '';
    try {
      print("ImageFile = " + imageFile.name);
      print("inprovicer");
      final path = 'files/${imageFile.name}';
      final file = File(imageFile.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      urlDownload = await snapshot.ref.getDownloadURL();
      // uploadUrl(urlDownload);
      return urlDownload;
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    } catch (e) {
      throw Exception(e.toString());
    }
    return "";
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _fireCloudUser.doc(uid).get();
      final data = documentSnapshot.data();
      if (data != null) {
        return UserModel.fromMap(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("No data found uid = $uid");
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    }
    throw Exception("Failed to get user data."); // Added throw statement
  }
}
