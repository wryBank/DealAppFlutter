import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/postmodel.dart';

class PostProvider {
  Future<Query<PostModel>> getPosts() async {
    final queryPost = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('detail')
        .withConverter<PostModel>(
          fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
          toFirestore: (post, _) => post.toJson(),
        );
    return queryPost;
  }

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

  Future<List> calculateDistances() async {
    print("in calculateDistances");
    Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(
        'Current location: ${currentLocation.latitude}, ${currentLocation.longitude}');

    final queryPost =
        FirebaseFirestore.instance.collection('posts').orderBy('detail').get();
    final querySnapshot = await queryPost;
    List<Map<String, dynamic>> postsWithDistance = [];

    List<PostModel> listBeforeSort =
        querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
    Map<PostModel, double> postDistances = {};
    for (var post in listBeforeSort) {
      double distanceInMeters = Geolocator.distanceBetween(
          currentLocation.latitude,
          currentLocation.longitude,
          post.latitude!,
          post.longitude!);
      double distanceInKilometers = distanceInMeters / 1000;
      postsWithDistance.add({
        'post': post,
        'distance': distanceInKilometers,
      });
      postDistances[post] = distanceInKilometers;
      print(
          'Distance from current location to post ${post.detail}: post latitude is ${post.latitude}: post long is ${post.longitude} $distanceInKilometers km');
    }

    postsWithDistance.sort((a, b) => a['distance'].compareTo(b['distance']));

    List<Map<String,dynamic>> sortedPosts = postsWithDistance.map((e) {
      return {
        'post': e['post'] as PostModel, // 'post' is the key, 'e['post']' is the value
        'distance': e['distance'] as double,
      };
    }).toList();

    // var sortedPosts = postDistances.entries.toList()
    //   ..sort((e1, e2) => e1.value.compareTo(e2.value));

    //   for(var post in sortedPosts){
    // print(
    //     'Distance from current location to post ${post.key.detail}: ${post.value} km');
    //   }
    //   List<PostModel> sortedPostModel = sortedPosts.map((e) => e.key).toList();
    //   print(sortedPostModel);
    //   return sortedPostModel;
    print(postsWithDistance);
    return postsWithDistance;
  }
}
