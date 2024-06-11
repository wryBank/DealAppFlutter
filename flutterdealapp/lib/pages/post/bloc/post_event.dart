

import 'package:flutter/material.dart';

@immutable 
abstract class PostEvent  {
  const PostEvent();
}

class getPostData extends PostEvent {
}
class getPostListData extends PostEvent {
}
