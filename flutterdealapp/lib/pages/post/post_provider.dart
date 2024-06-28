import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdealapp/model/postmodel_indevice.dart';
import 'package:flutterdealapp/pages/Deal/deal_page.dart';
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
    // print("curla: $curLa");
    // print("curlong: $CurLong");
    double distanceInMeters =
        Geolocator.distanceBetween(curLa, CurLong, la, long);
    double distanceInKilometers = distanceInMeters / 1000;
    // print( 'Distance from current location to post ${la}: post latitude is ${la}: post long is ${long} $distanceInKilometers km');
    return distanceInKilometers;
  }

  Future<List<PostModel>> getPostFilter(bool isFindJob, bool isFindJobAll,
      bool inprogress, bool statusAll, bool ownPost, bool allPost) async {
    final docpost = await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .map(
                (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());

    await getLocation();
    List<PostModel> postsList = [];
    List<PostModel> postsList2 = [];
    String status;

    print("inbfi");
    if (inprogress == true) {
      status = 'inprogress';
    } else {
      status = 'done';
    }

    if (isFindJobAll != true && statusAll != true && allPost != true) {
      postsList = docpost;

      print("status: $status");
      print("isFindJob: $isFindJob");
      // postsList.where((element) => element.isFindJob == isFindJob && element.status == status);
      // print("------------------------------------${postsList.where((element) => element.isFindJob == isFindJob && element.status == status).toList()}");
      postsList2 = postsList.where((element) {
        bool matchIsFindjob = element.isFindJob == isFindJob;
        bool matchStatus = element.status == status;
        bool matchIstake = element.isTake == true;
        // String? takeby = "";

        // if(ownPost == true){
        //     element.uid = FirebaseAuth.instance.currentUser?.uid.toString();}
        //   else{
        //     element.takeby = FirebaseAuth.instance.currentUser?.uid.toString();
        //   }

        print("matchIsFindjob: $matchIsFindjob");
        print("matchStatus: $matchStatus");
        print("matchIstake: $matchIstake");
        // print("takeby: $takeby");
        print("ownPost: $ownPost");
        return matchIsFindjob &&
            matchStatus &&
            matchIstake &&
            (ownPost ? element.uid == uid : element.takeby == uid);
      }).toList();

      print("postsListinif: $postsList2");
    } else if (isFindJobAll && statusAll && allPost) {
      print("status: $status");
      postsList = docpost;
      postsList2 = postsList.where((element) {
        bool matchIstake = element.isTake == true;
        print("matchIstake: $matchIstake");
        print("ownPost: $ownPost");
        return matchIstake;
      }).toList();
      print("list: $postsList2");
    } else if (isFindJobAll && allPost) {
      print("in isFindJobAll && allPost");
      print("status: $status");
      postsList = docpost;
      postsList2 = postsList.where((element) {
        bool matchIstake = element.isTake == true;
        print("matchIstake: $matchIstake");
        print("ownPost: $ownPost");
        return (inprogress
                ? element.status == 'inprogress'
                : element.status == 'done') &&
            matchIstake;
      }).toList();
      print("list: $postsList2");
    } else if (isFindJobAll && statusAll) {
      print("in isFindJobAll && statusAll");
      print("status: $status");
      postsList = docpost;
      postsList2 = postsList.where((element) {
        bool matchIstake = element.isTake == true;
        // String? takeby = "";
        // if(ownPost == true){
        //     element.uid = FirebaseAuth.instance.currentUser?.uid.toString();}
        //   else{
        //     element.takeby = FirebaseAuth.instance.currentUser?.uid.toString();
        //   }
        print("matchIstake: $matchIstake");
        // print("takeby: $takeby");
        print("ownPost: $ownPost");
        return matchIstake &&
            (ownPost ? element.uid == uid : element.takeby == uid);
      }).toList();
      print("list: $postsList2");
    } else if (isFindJobAll == true) {
      print("in isFindJobAll");
      print("status: $status");
      postsList = docpost;
      postsList2 = postsList.where((element) {
        bool matchStatus = element.status == status;
        bool matchIstake = element.isTake == true;
        // String? takeby = "";
        // if(ownPost == true){
        //     element.uid = FirebaseAuth.instance.currentUser?.uid.toString();}
        //   else{
        //     element.takeby = FirebaseAuth.instance.currentUser?.uid.toString();
        //   }
        print("matchStatus: $matchStatus");
        print("matchIstake: $matchIstake");
        // print("takeby: $takeby");
        print("ownPost: $ownPost");
        return matchStatus &&
            matchIstake &&
            (ownPost ? element.uid == uid : element.takeby == uid);
      }).toList();
      print("list: $postsList2");
    } else if (statusAll == true) {
      print("in statusAll");
      print("status: $status");
      postsList = docpost;
      postsList2 = postsList.where((element) {
        bool matchIsFindjob = element.isFindJob == isFindJob;
        bool matchIstake = element.isTake == true;
        // String? takeby = "";
        // if(ownPost == true){
        //     element.uid = FirebaseAuth.instance.currentUser?.uid.toString();}
        //   else{
        //     element.takeby = FirebaseAuth.instance.currentUser?.uid.toString();
        //   }
        print("matchIsFindjob: $matchIsFindjob");
        print("matchIstake: $matchIstake");
        // print("takeby: $takeby");
        print("ownPost: $ownPost");
        return matchIsFindjob &&
            matchIstake &&
            (ownPost ? element.uid == uid : element.takeby == uid);
      }).toList();
      print("list: $postsList2");
    } else if (allPost == true) {
      postsList = docpost;
      postsList2 = postsList.where((element) {
        bool matchIsFindjob = element.isFindJob == isFindJob;
        bool matchStatus = element.status == status;
        bool matchIstake = element.isTake == true;
        // String? takeby = "";
        // if(ownPost == true){
        //     element.uid = FirebaseAuth.instance.currentUser?.uid.toString();}
        //   else{
        //     element.takeby = FirebaseAuth.instance.currentUser?.uid.toString();
        //   }
        print("matchIsFindjob: $matchIsFindjob");
        print("matchStatus: $matchStatus");
        print("matchIstake: $matchIstake");
        // print("takeby: $takeby");
        // print("ownPost: $ownPost");
        return matchIsFindjob && matchStatus && matchIstake;
      }).toList();

      // postsList.where((element) => element.isFindJob == true);
      // postsList.where((element) => element.isFindJob == true);
    }
    print("posts length: ${postsList.length}");
    print("postsList: $postsList");
    postsList.forEach((element) async {
      element.distance = calculateDistances(currentLatitude, currentLongtitude,
          element.latitude!, element.longitude!);
    });
    postsList.sort((a, b) => a.distance!.compareTo(b.distance!));
    // return postsList;

    // final docpost = await FirebaseFirestore.instance
    //     .collection('posts')
    //     .get()
    //     .then((querySnapshot) => querySnapshot.docs
    //         .map(
    //             (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
    //         .toList());

    // await getLocation();
    // List<PostModel> postsList = docpost;
    // print("posts length: ${postsList.length}");
    // print("postsList: $postsList");
    // postsList.forEach((element) async {
    //   element.distance = calculateDistances(currentLatitude, currentLongtitude,
    //       element.latitude!, element.longitude!);
    // });
    // postsList.sort((a, b) => a.distance!.compareTo(b.distance!));
    return postsList2;
  }

  Future<List<PostModel>> getOwnDeal(String uid) async {
    final docRef = await FirebaseFirestore.instance
        .collection('posts')
        .where(
          'isTake',
          isEqualTo: true,
        )
        .where(
          'takeby',
          isEqualTo: uid,
        )
        .where('status', isEqualTo: 'inprogress')
        .get();
    final docRef2 = await FirebaseFirestore.instance
        .collection('posts')
        .where(
          'isTake',
          isEqualTo: true,
        )
        .where(
          'uid',
          isEqualTo: uid,
        )
        .where('status', isEqualTo: 'inprogress')
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

  Future<List<PostModel>> getOwnDealDone(String uid) async {
    final docRef = await FirebaseFirestore.instance
        .collection('posts')
        .where(
          'isTake',
          isEqualTo: true,
        )
        .where(
          'takeby',
          isEqualTo: uid,
        )
        .where('status', isEqualTo: 'done')
        .get();
    final docRef2 = await FirebaseFirestore.instance
        .collection('posts')
        .where(
          'isTake',
          isEqualTo: true,
        )
        .where(
          'uid',
          isEqualTo: uid,
        )
        .where('status', isEqualTo: 'done')
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

  Future takePost(String postId, String uid) async {
    print("in takePost");
    final docRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    final snapshot = await docRef.get();

    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final usernapshot = await userRef.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final userdata = usernapshot.data() as Map<String, dynamic>;
      print("data: $data");
      if (userdata['coin'] < data['totalprice']) {
        return "not enough coin2";
      }
      if (data['isTake'] == false) {
        if (userdata['coin'] > data['totalprice']) {
          await userRef.update({'coin': userdata['coin'] - data['totalprice']});
          await docRef
              .update({'isTake': true, 'takeby': uid, 'status': 'inprogress'});
          return true;
        } else {
          return "not enough coin";
        }
      } else {
        print("post is taken");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkPostStatus(String postId) async {
    final docRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    final snapshot = await docRef.get();
    bool cantake = false;

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      print("data: $data");
      if (data['isTake'] == false) {
        print("post is not");
        cantake = true;
      } else {
        print("post is taken");
        cantake = false;
      }
    }
    return cantake;
  }

  Future<Query<PostModel>> getPosts() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
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
        .where('uid', isNotEqualTo: uid)
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
    // print("posts length: ${postsList.length}");
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
    // print("posts length: ${postsList.length}");
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
