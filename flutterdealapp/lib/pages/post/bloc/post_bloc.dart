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
        // repository.getPosts();
        List<PostModel> postModel = await repository.postProvider.getPosts2();
        // print("postModel: $postModel");

        // emit(PostLoaded(postModel));
        emit(PostListLoaded(postModel));
      } catch (e) {}
    });
    // on<getPostListData>((event, emit) async {
    //   emit(PostLoading());
    //   try {
    //     print("inbloc post2");
    //     // repository.getPosts();
    //     print("------------------------------------------------------------------");
    //     repository.postProvider.calculateDistances();
    //     List postModel = await repository.postProvider.calculateDistances();
    //     emit(PostListLoaded(postModel));
    //   } catch (e) {}
    // });
    on<getPostById>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post3");
        // repository.getPosts();
        print(
            "------------------------------------------------------------------");
        // repository.getPostById(event.userId);
        List<PostModel> postModel = await repository.getPostById(event.userId);
        emit(PostLoaded(postModel));
      } catch (e) {}
    });
    on<getPostByType>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post4");
        // repository.getPosts();
        print(
            "------------------------------------------------------------------");
        // repository.getPostByType(event.isFindJob);
        List<PostModel> postModel =
            await repository.getPostByType(event.isFindJob);
        emit(PostListLoaded(postModel));
      } catch (e) {}
    });
    // on<getPostByType>((event, emit) async {
    //   emit(PostLoading());
    //   try {
    //     print("inbloc post4");
    //     // repository.getPosts();
    //     print(
    //         "------------------------------------------------------------------");
    //     // repository.getPostByType(event.isFindJob);
    //     List<PostModel> postModel =
    //         await repository.getPostByType(event.isFindJob);
    //     emit(PostListLoaded(postModel));
    //   } catch (e) {}
    // });
    on<selectBoxPostType>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post5");
        // repository.getPosts();
        print(
            "------------------------------------------------------------------");
        emit(selectBoxPostTypeSuccess(event.isFindJob));
      } catch (e) {}
    });
    on<getPostDetail>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post6");
        // repository.getPosts();
        print(
            "------------------------------------------------------------------");
        // repository.getPostDetail(event.postId);
        PostModel postModel = await repository.getPostDetail(event.postId);
        // print("postModel: $postModel");
        emit(postDetailLoaded(postModel));
      } catch (e) {}
    });

    on<takePostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post7");
        // repository.getPosts();
        print(
            "------------------------------------------------------------------");
        var takepost = await repository.takePost(event.postId, event.uid);
        if (takepost == true) {
          emit(takePostSuccess());
        } else {
          print("print ${takepost}");
        }
      } catch (e) {}
    });
    on<getOwnDeal>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post8");
        // repository.getPosts();
        print(
            "------------------------------------------------------------------");
        // repository.getOwnDeal(event.uid);
        List<PostModel> postModel = await repository.getOwnDeal(event.uid);
        emit(PostListLoaded(postModel));
      } catch (e) {}
    });
    on<getOwnDealDone>((event, emit) async {
      emit(PostLoading());
      try {
        print("inbloc post9");
        // repository.getPosts();
        print(
            "------------------------------------------------------------------");
        // repository.getOwnDeal(event.uid);
        List<PostModel> postModel = await repository.getOwnDealDone(event.uid);
        emit(PostListLoaded(postModel));
      } catch (e) {}
    });
  }
}
