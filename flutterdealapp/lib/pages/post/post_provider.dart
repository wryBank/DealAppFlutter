import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdealapp/model/postmodel_indevice.dart';
import 'package:flutterdealapp/pages/post/bloc/post_event.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/postmodel.dart';

class PostProvider {
  // double currentLatitude = 0;
  // double currentLongtitude = 0;
  // Future<void> getLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   print(position);
  //   currentLatitude = position.latitude;
  //   currentLongtitude = position.longitude;
  // }
  calculateDistances(double curLa, double CurLong, double la, double long) {
    print("curla: $curLa");
    print("curlong: $CurLong");
    double distanceInMeters =
        Geolocator.distanceBetween(curLa, CurLong, la, long);
    double distanceInKilometers = distanceInMeters / 1000;
    // print( 'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
    return distanceInKilometers;
  }

  Future<List<PostModel>> getOwnDeal(String uid) async {
    final docRef = await FirebaseFirestore.instance
        .collection('posts')
        .where('isTake', isEqualTo: true,)
        .where('takeby', isEqualTo: uid,)
        .get();
    final docRef2 = await FirebaseFirestore.instance
        .collection('posts')
        .where('isTake', isEqualTo: true,)
        .where('uid', isEqualTo: uid,)
        .get();

        final alldocs = {...docRef.docs, ...docRef2.docs};
    await getLocation();

    // final querySnapshot = await docRef;
    List<PostModel> postsList = alldocs
        .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    postsList.forEach((element) async {
      element.distance = calculateDistances(currentLatitude, currentLongtitude,
          element.latitude!, element.longitude!);
    });
    postsList.sort((a, b) => a.distance!.compareTo(b.distance!));
    print("posts length: ${postsList.length}");
    return postsList;
  }

  Future<void> takePost(String postId, String uid) async {
    final docRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    if (checkPostStatus(postId) == false) {
      await docRef.update({'isTake': true, 'takeby': uid, 'status': 'request'});
    } else {}
  }

  Future checkPostStatus(String postId) async {
    final docRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      if (data['istake'] == true) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<Query<PostModel>> getPosts() async {
    // print("in getPosts");
    // // Geolocator.checkPermission();
    // // Geolocator.requestPermission();
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    // print("Current location: ${position.latitude}, ${position.longitude}------");
    // double currentLatitude = position.latitude;
    // double currentLongtitude = position.longitude;

    // --------------------------------------------------
    final queryPost = FirebaseFirestore.instance
        .collection('posts')
        .where('isTake', isEqualTo: false)
        // .orderBy('detail')
        .withConverter<PostModel>(
          fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
          toFirestore: (post, _) => post.toJson(),
        );
    return queryPost;
    // final querySanpshot = await postModel.get();
    // final posts = querySanpshot.docs.map((doc) => doc.data()).toList();
    // final posts =  FirebaseFirestore.instance
    //     .collection('posts').get();

    //   final querySnapshot = await posts;
    //     // .where('isTake', isEqualTo: false)
    //     // .orderBy('detail')
    //     // .withConverter<PostModel>(
    //     //   fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
    //     //   toFirestore: (post, _) => post.toJson(),
    //     // );
    //     List<PostModel> postsList = querySnapshot.docs
    //   .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
    //   .toList();

    // postsList.forEach((element) async{
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    //   element.distance = calculateDistances2(position.latitude, position.longitude,
    //       element.latitude!, element.longitude!);

    //   final docRef = FirebaseFirestore.instance.collection('posts').doc(element.pid);
    //   await docRef.update({'distance': element.distance});

    // });
    // // postsList.sort((a, b) => a.distance!.compareTo(b.distance!));
    // // postsList = posts;
    // final queryPost = FirebaseFirestore.instance
    //     .collection('posts')
    //     .where('isTake', isEqualTo: false)
    //     .orderBy('distance').limit(50)
    //     .withConverter<PostModel>(
    //       fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
    //       toFirestore: (post, _) => post.toJson(),
    //     );

    // return queryPost;
  }

  Future<List<PostModel>> getPostById(String userId) async {
    // final queryPost = FirebaseFirestore.instance
    //     .collection('posts')
    //     .where('uid', isEqualTo: userId)
    //     .withConverter<PostModel>(
    //       fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
    //       toFirestore: (post, _) => post.toJson(),
    //     );
    // return queryPost;
    await getLocation();
    final posts = FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: userId)
        .get();

    final querySnapshot = await posts;
    List<PostModel> postsList = querySnapshot.docs
        .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    postsList.forEach((element) async {
      element.distance = calculateDistances(currentLatitude, currentLongtitude,
          element.latitude!, element.longitude!);
    });
    postsList.sort((a, b) => a.distance!.compareTo(b.distance!));
    print("posts length: ${postsList.length}");
    return postsList;
  }

  Future<void> getLocation() async {
    Geolocator.checkPermission();
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position);
    currentLatitude = position.latitude;
    currentLongtitude = position.longitude;
  }

  Future<List<PostModel>> getPostByType(bool isFindJob) async {
    // final queryPost = FirebaseFirestore.instance
    //     .collection('posts')
    //     .where('isFindJob', isEqualTo: isFindJob)
    //     .where('isTake', isEqualTo: false)
    //     .withConverter<PostModel>(
    //       fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
    //       toFirestore: (post, _) => post.toJson(),
    //     );
    // return queryPost;
    await getLocation();
    final posts = FirebaseFirestore.instance
        .collection('posts')
        .where('isFindJob', isEqualTo: isFindJob)
        .where('isTake', isEqualTo: false)
        .get();

    final querySnapshot = await posts;
    List<PostModel> postsList = querySnapshot.docs
        .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    postsList.forEach((element) async {
      element.distance = calculateDistances(currentLatitude, currentLongtitude,
          element.latitude!, element.longitude!);
    });
    postsList.sort((a, b) => a.distance!.compareTo(b.distance!));
    print("posts length: ${postsList.length}");
    return postsList;
  }

  // Future<void> getLocation() async {
  //   Geolocator.checkPermission();
  //   Geolocator.requestPermission();
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   print(position);
  //   currentLatitude = position.latitude;
  //   currentLongtitude = position.longitude;
  // }

  double currentLatitude = 0;
  double currentLongtitude = 0;

  Future<List<PostModel>> getPosts2() async {
    await getLocation();
    final posts = FirebaseFirestore.instance
        .collection('posts')
        .where('isTake', isEqualTo: false)
        .get();

    final querySnapshot = await posts;
    List<PostModel> postsList = querySnapshot.docs
        .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    postsList.forEach((element) async {
      element.distance = calculateDistances(currentLatitude, currentLongtitude,
          element.latitude!, element.longitude!);
    });
    postsList.sort((a, b) => a.distance!.compareTo(b.distance!));
    print("posts length: ${postsList.length}");
    return postsList;
  }

  // calculateDistances(double curLa, double CurLong, double la, double long) {
  //   print("curla: $curLa");
  //   print("curlong: $CurLong");
  //   double distanceInMeters =
  //       Geolocator.distanceBetween(curLa, CurLong, la, long);
  //   double distanceInKilometers = distanceInMeters / 1000;
  //   // print( 'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
  //   return distanceInKilometers;
  // }

  // Future<List<PostModel>> getPosts2() async {
  // final queryPost =
  //     FirebaseFirestore.instance.collection('posts').orderBy('detail').get();

  // final querySnapshot = await queryPost;
  // List<PostModel> listBeforeSort =
  //     querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
  // print(listBeforeSort);

  // List<MapEntry<PostModel, double>> sortedPosts = await calculateDistances();

  // final

  // return listBeforeSort;
  // }

  // Future<List> calculateDistances2() async {
  //   print("in calculateDistances");
  //   Position currentLocation = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print(
  //       'Current location: ${currentLocation.latitude}, ${currentLocation.longitude}');

  //   final queryPost =
  //       FirebaseFirestore.instance.collection('posts').orderBy('detail').get();
  //   final querySnapshot = await queryPost;
  //   List<Map<String, dynamic>> postsWithDistance = [];

  //   List<PostModel> listBeforeSort =
  //       querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
  //   Map<PostModel, double> postDistances = {};
  //   for (var post in listBeforeSort) {
  //     double distanceInMeters = Geolocator.distanceBetween(
  //         currentLocation.latitude,
  //         currentLocation.longitude,
  //         post.latitude!,
  //         post.longitude!);
  //     double distanceInKilometers = distanceInMeters / 1000;
  //     postsWithDistance.add({
  //       'post': post,
  //       'distance': distanceInKilometers,
  //     });
  //     postDistances[post] = distanceInKilometers;
  //     print(
  //         'Distance from current location to post ${post.detail}: post latitude is ${post.latitude}: post long is ${post.longitude} $distanceInKilometers km');
  //   }

  //   postsWithDistance.sort((a, b) => a['distance'].compareTo(b['distance']));

  //   List<Map<String, dynamic>> sortedPosts = postsWithDistance.map((e) {
  //     return {
  //       'post': e['post']
  //           as PostModel, // 'post' is the key, 'e['post']' is the value
  //       'distance': e['distance'] as double,
  //     };
  //   }).toList();

  //   // var sortedPosts = postDistances.entries.toList()
  //   //   ..sort((e1, e2) => e1.value.compareTo(e2.value));

  //   //   for(var post in sortedPosts){
  //   // print(
  //   //     'Distance from current location to post ${post.key.detail}: ${post.value} km');
  //   //   }
  //   //   List<PostModel> sortedPostModel = sortedPosts.map((e) => e.key).toList();
  //   //   print(sortedPostModel);
  //   //   return sortedPostModel;
  //   print(postsWithDistance);

  //   return postsWithDistance;
  // }

  final _fireCloud = FirebaseFirestore.instance.collection("posts");
  Future<PostModel> getPostDetail(String postId) async {
    print("in getpostdetail");
    try {
      DocumentSnapshot documentSnapshot = await _fireCloud.doc(postId).get();
      // print(documentSnapshot.data());
      return PostModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    }
    throw Exception("Failed to get user data."); // Added throw statement
  }
}
