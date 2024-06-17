

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
