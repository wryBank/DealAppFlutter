
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/pages/post/post_provider.dart';

class PostRepository {
  final PostProvider postProvider;
  PostRepository({required this.postProvider});
  

  Future<Query<PostModel>> getPosts() async {
    return await postProvider.getPosts();
  }
  
}
