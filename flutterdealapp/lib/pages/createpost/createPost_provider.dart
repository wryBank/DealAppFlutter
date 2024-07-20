import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdealapp/firebase/PushNotificationService.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:googleapis/content/v2_1.dart';

import '../../model/usermodel.dart';

class CreatePostProvider {
  final _fireCloudUser = FirebaseFirestore.instance.collection("users");
  final _fireCloudPost = FirebaseFirestore.instance.collection("posts");
  final _firefirestore = FirebaseFirestore.instance;
  final _firestore = FirebaseStorage.instance;
  final _uid = FirebaseAuth.instance.currentUser?.uid;
  PlatformFile? imageFile;

  Future<Map<String, double>> getUserlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    final double currentLatitude = position.latitude;
    final double currentLongitude = position.longitude;
    return {'latitude': currentLatitude, 'longitude': currentLongitude};
  }

  Future<void> createPost(PostModel postModel) async {
    List<String> userLessDistances = [];
    try {
      print("inprovicer");
      print("uid = " + _uid!);
      final userRef = _fireCloudUser.doc(_uid);
      final usersnapshot = await userRef.get();
      if (usersnapshot.exists) {
        final userData = usersnapshot.data() as Map<String, dynamic>;
        if (userData['coin'] < postModel.totalPrice) {
          throw Exception("Not enough coin");
        } else if (userData['coin'] >= postModel.totalPrice) {
          await userRef
              .update({'coin': userData['coin'] - postModel.totalPrice});
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
          Map<String, double> location = await getUserlocation();
          double latitude = location['latitude']!;
          double longitude = location['longitude']!;

          final distance = calculateDistances(
              latitude, longitude, postModel.latitude!, postModel.longitude!);
          PushNotificationService.sendNotificationCreatePost(
              await countUsersWithin3KmOfPost(postModel),
              docRef.id,
              "New Post",
              "คนสร้างดีลใหม่ใกล้ๆคุณ [$distance km]",
              postModel.title!);
          await countUsersWithin3KmOfPost(postModel);
          print(countUsersWithin3KmOfPost(postModel));
          // double coinleft = userData['coin'] - postModel.totalPrice;
          // return coinleft;
        }
      } else {
        throw Exception("No user data found");
      }
      // await _fireCloudPost.add(postModel.toMap()).then((DocumentReference docRef) {
      //   docRef.update({'pid': docRef.id});

      // });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  calculateDistances(double curLa, double CurLong, double la, double long) {
    // print("curla: $curLa");
    // print("curlong: $CurLong");
    double distanceInMeters =
        Geolocator.distanceBetween(curLa, CurLong, la, long);
    double distanceInKilometers = distanceInMeters / 1000;
    // print( 'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
    return distanceInKilometers;
  }

  Future<List<String>> countUsersWithin3KmOfPost(PostModel postModel) async {
    print("Counting users within 3 km of post");
    List<String> usersWithin3Km = [];
    final usersRef = FirebaseFirestore.instance.collection('users');
    final postLat = postModel.latitude;
    final postLon = postModel.longitude;

    try {
      final querySnapshot = await usersRef.get();
      for (var doc in querySnapshot.docs) {
        final userData = doc.data() as Map<String, dynamic>;
        final userLat = userData['lastLatitude'];
        final userLon = userData['lastLongitude'];
        final distance =
            calculateDistances(postLat!, postLon!, userLat, userLon);

        if (distance < 10 &&
            userData['uid'] != FirebaseAuth.instance.currentUser!.uid) {
          usersWithin3Km.add(userData['userToken']);
        }
      }
      print("Users within 3 km of post: $usersWithin3Km");
    } catch (e) {
      print("Error fetching users: $e");
    }

    return usersWithin3Km;
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
