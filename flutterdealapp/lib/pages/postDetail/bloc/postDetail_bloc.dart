import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/post/post_repo.dart';
import 'package:flutterdealapp/pages/postDetail/bloc/postDetail.state.dart';
import 'package:flutterdealapp/pages/postDetail/bloc/postDetail_event.dart';


class postDetailBloc extends Bloc<PostDetailEvent, postDetailState> {
  final PostRepository repository;
  postDetailBloc(this.repository) : super(postDetailState()) {
    
    on<clickButton>((event, emit) async {
      repository.postProvider.updateStatusReceived(event.postId, event.isReceived, event.uidPostby, event.isFindJob);
      emit(clickPostState(isClickReceived: true));
    });
   on<clickButton2>((event, emit) async {
      repository.postProvider.updateStatusGave(event.postId, event.isGave, event.uidtakeby, event.isFindJob);
      emit(clickPostState2(isGraveClicked: true));
    });
  }
}
