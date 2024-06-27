import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdealapp/model/postmodel_indevice.dart';

import '../../../model/postmodel.dart';

class PostState {

}
class PostInitial extends PostState {
}
class PostLoading extends PostState {
  
}
class PostLoaded extends PostState {
  final List<PostModel> postModel;
  PostLoaded(this.postModel);
}
// class PostListLoading extends PostState {
//   final List<PostModel> oldPost;
//   final bool isFirstFetch;
//   PostListLoading(this.oldPost,{this.isFirstFetch = false});
// }
class PostListLoaded extends PostState {
  final List<PostModel> postModel;
    // final Query<PostModel_indevice> postModel;
  PostListLoaded(this.postModel);
}
class selectBoxPostTypeSuccess extends PostState {
  final bool isFindJob;
  selectBoxPostTypeSuccess(this.isFindJob);
}
class postDetailLoaded extends PostState {
  final PostModel postModel;
  postDetailLoaded(this.postModel);
}
class postDetailLoaded2 extends PostState {
  final PostModel postModel;
  postDetailLoaded2(this.postModel);
}
class takePostSuccess extends PostState {
  // final String postId;
  // final String uid;
  // takePostSuccess({required this.postId, required this.uid});
}
class statusCheckSuccess extends PostState {
  final bool isFindJob;
  final bool isTake;
  
  statusCheckSuccess(this.isFindJob, this.isTake);
}
class getPostFilterState extends PostState {
  final bool isFindJob;
  final bool isTake;
  getPostFilterState(this.isFindJob, this.isTake);
}