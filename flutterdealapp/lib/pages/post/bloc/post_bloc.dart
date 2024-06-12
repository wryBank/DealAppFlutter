
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/model/postmodel_indevice.dart';
import 'package:flutterdealapp/pages/UserBloc/bloc/user_state.dart';
import 'package:flutterdealapp/pages/post/bloc/post_event.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';

import '../post_repo.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository; 
  PostBloc(this.repository) : super(PostInitial()) {
    on<getPostData>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post");
        repository.getPosts();
        Query<PostModel> postModel = await repository.postProvider.getPosts();
        emit(PostLoaded(postModel));
      } catch (e) {}
    });
  on<getPostListData>((event, emit) async {
    emit(PostLoading());
    try {
      print("inbloc post2");
      // repository.getPosts();
      print("------------------------------------------------------------------");
      repository.postProvider.calculateDistances();
      List postModel = await repository.postProvider.calculateDistances();
      emit(PostListLoaded(postModel));
    } catch (e) {}
  });
  on<getPostById>((event, emit) async {
    emit(PostLoading());
    try {
      print("inbloc post3");
      // repository.getPosts();
      print("------------------------------------------------------------------");
      repository.getPostById(event.userId);
      Query<PostModel> postModel = await repository.getPostById(event.userId);
      emit(PostLoaded(postModel));
    } catch (e) {}
  });
  }

}