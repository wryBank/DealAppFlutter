import 'package:cloud_firestore/cloud_firestore.dart';

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
      // List<MapEntry<PostModel, double>> postModel ;
  PostListLoaded(this.postModel);
}