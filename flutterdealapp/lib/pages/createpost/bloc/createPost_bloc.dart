import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../createPost_repo.dart';
import 'createPost_event.dart';
import 'createPost_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, createPostState> {
  final CreatePostRepository repository;
  CreatePostBloc(this.repository) : super(createPostInitial()) {
    
    
    
    on<SubmitPost>((event, emit) async {
      emit(createPostLoading());
      print("loading");
      try {
        print("inbloc post");
        repository.createPost(event.postModel);
        print("postmodel = ${event.postModel}");
        emit(createPostSuccess());
      } catch (e) {
        emit(createPostError());
      }
    });
    on<addImage>((event, emit) async {
      emit(createPostLoading());
      try {
        print("inbloc pos2t");
        // repository.addImage(event.image);
        
        emit(addImageSuccess(event.imageFile!));
      } catch (e) {
        emit(createPostError());
      }
    });
    on<selectBox>((event, emit) async {
      emit(createPostLoading());
      try {
        print("inbloc post3");
        emit(selectBoxSuccess(event.isFindJob!));
      } catch (e) {
        emit(createPostError());
      }
    });
  }
}
