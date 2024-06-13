
import 'package:flutterdealapp/model/postmodel.dart';

import 'createPost_provider.dart';

class CreatePostRepository {
  final CreatePostProvider createPostProvider;

  CreatePostRepository({required this.createPostProvider});

  Future<void> createPost(PostModel postModel) async {
    
    await createPostProvider.createPost(postModel);
  }
  Future<void> getUserByID(String uid) async {
    await createPostProvider.getUserData(uid);
  }
}