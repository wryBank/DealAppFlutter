import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutterdealapp/model/postmodel.dart';

class createPostState{
  PostModel? postModel;
  createPostState({this.postModel});

}
class createPostInitial extends createPostState{

}
class createPostLoading extends createPostState{

}
class createPostSuccess extends createPostState{
}
class  createPostError extends createPostState{

}
class addImageSuccess extends createPostState{
  
  
  PlatformFile image;
  addImageSuccess(this.image);
}