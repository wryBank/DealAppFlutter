
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterdealapp/model/postmodel.dart';

@immutable
abstract class CreatePostEvent {
  const CreatePostEvent();
}

class SubmitPost extends CreatePostEvent {
  PostModel postModel;
  SubmitPost(this.postModel);
}
class addImage extends CreatePostEvent {
  
  PlatformFile? imageFile;
  addImage({this.imageFile});

}
class selectBox extends CreatePostEvent {
  bool? isFindJob;
  selectBox({this.isFindJob});
}
