import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/createpost/createPost_provider.dart';

import '../createPost_repo.dart';
import 'createPost_event.dart';
import 'createPost_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, createPostState> {
  final CreatePostRepository repository;
  CreatePostBloc(this.repository) : super(createPostInitial()) {
    CreatePostProvider pr = CreatePostProvider();

    on<SubmitPost>((event, emit) async {
      emit(createPostLoading());
      print("loading");
      try {
        print("inbloc post");
        // await repository.createPost(event.postModel);
        await pr.createPost(event.postModel);
        print("postmodel = ${event.postModel}");
        // double? coinleft = await pr.createPost(event.postModel);

        // emit(calTotalSuccess(coinleft!));
        emit(createPostSuccess());
      } catch (e) {
        print("error : $e");
        emit(createPostError("error"));
      }
    });
    on<addImage>((event, emit) async {
      emit(createPostLoading());
      try {
        print("inbloc pos2t");
        // repository.addImage(event.image);

        emit(addImageSuccess(event.imageFile!));
      } catch (e) {
        print("e2rror");
        emit(createPostError("image eerror"));
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
    on<calTotal>((event, emit) async {
      emit(createPostLoading());
      try {
        print("inbloc post4");
        var total = event.priceBuy! + event.pricePay!;
        print("event.priceBuy = ${event.priceBuy}");
        print("event.pricePay = ${event.pricePay}");
        emit(calTotalSuccess(total));
      } catch (e) {
        emit(createPostError());
      }
    });
  }
}
