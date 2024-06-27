

import 'package:flutter/material.dart';

@immutable 
abstract class PostEvent  {
  const PostEvent();
}

class getPostData extends PostEvent {
}
class getPostListData extends PostEvent {
}
class getPostById extends PostEvent {
  final String userId;
  getPostById(this.userId);
}
class getPostByType extends PostEvent {
  final bool isFindJob;
  getPostByType(this.isFindJob);
  // final bool isFindJob;
  // final bool isTake;
  
  // getPostByType(this.isFindJob );
}
class selectBoxPostType extends PostEvent {
  final bool isFindJob;
  selectBoxPostType(this.isFindJob);
}
class getPostDetail extends PostEvent {
  final String postId;
  getPostDetail(this.postId);
}
class getPostDetail2 extends PostEvent {
  final String postId;
  getPostDetail2(this.postId);
}
class getPostEvent extends PostEvent {
}
class takePostEvent extends PostEvent {
  final String postId;
  final String uid;
  takePostEvent({required this.postId, required this.uid});
}
class getOwnDeal extends PostEvent {
  // final String postId;
  final String uid;
  getOwnDeal({required this.uid});
}
class getOwnDealDone extends PostEvent {
  // final String postId;
  final String uid;
  getOwnDealDone({required this.uid});
}
class getPostFilter extends PostEvent {
  final bool isFindJob;
  final bool isFindJobAll;
  final bool inprogress;
  final bool statusAll;
  final bool ownPost;
  final bool allPost;
  
  getPostFilter(this.isFindJob, this.isFindJobAll, this.inprogress, this.statusAll, this.ownPost, this.allPost);
}
