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
  String? error;

  createPostError([this.error]);

}
class addImageSuccess extends createPostState{
  PlatformFile image;
  addImageSuccess(this.image);
}
class selectBoxSuccess extends createPostState{
  bool isFindJob;
  selectBoxSuccess(this.isFindJob);
}
class calTotalSuccess extends createPostState{
  double total;
  calTotalSuccess(this.total);
}