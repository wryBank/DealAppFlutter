
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/pages/post/post_provider.dart';

class PostRepository {
  final PostProvider postProvider;
  PostRepository({required this.postProvider});
  

  Future<Query<PostModel>> getPosts() async {
    return await postProvider.getPosts();
  }
  // Future<List<PostModel>> getPosts2() async {
  //   return await postProvider.getPosts2();
  // }
  // Future<void> calculateDistances() async {
  //   await postProvider.calculateDistances();
  // }
  Future<List<PostModel>> getPostById(String userId) async {
    return await postProvider.getPostById(userId);
  }
  Future<List<PostModel>> getPostByType(bool isFindJob) async {
    return await postProvider.getPostByType(isFindJob);
  }
  Future<PostModel> getPostDetail(String postId) async {
    return await postProvider.getPostDetail(postId);
  }
  Future<List<PostModel>> getPosts2(String postId) async {
    return await postProvider.getPosts2();
  }
  Future takePost(String postId, String uid , String uidPostby) async {
    return await postProvider.takePost(postId, uid,uidPostby);
  }
  Future getOwnDeal(String uid) async {
    return await postProvider.getOwnDeal(uid);
  }
  Future getOwnDealDone(String uid) async {
    return await postProvider.getOwnDealDone(uid);
  }
  Future getPostFilter(bool isFindJob, bool isFindJobAll, bool inprogress,bool statusAll, bool ownPost, bool allPost  ) async {
    return await postProvider.getPostFilter(isFindJob, isFindJobAll, inprogress, statusAll, ownPost, allPost);
  }
  Future updateStatusReceived(String postid , bool isGave,uidPostby,bool isFindJob) async {
    return await postProvider.updateStatusReceived(postid, isGave,uidPostby,isFindJob);
  }
}
