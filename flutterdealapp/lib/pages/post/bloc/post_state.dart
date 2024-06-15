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
  final Query<PostModel> postModel;
  PostLoaded(this.postModel);
}
class PostListLoaded extends PostState {
  final List postModel;
    // final Query<PostModel_indevice> postModel;
  PostListLoaded(this.postModel);
}
class selectBoxPostTypeSuccess extends PostState {
  final bool isFindJob;
  selectBoxPostTypeSuccess(this.isFindJob);
}
