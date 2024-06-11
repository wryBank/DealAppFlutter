import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/postmodel.dart';

class PostProvider {
  Future<Query<PostModel>> getPosts() async {
    final currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    

    final queryPost = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('detail')
        .withConverter<PostModel>(
          fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
          toFirestore: (post, _) => post.toJson(),
        );
    return queryPost;
  }
}
