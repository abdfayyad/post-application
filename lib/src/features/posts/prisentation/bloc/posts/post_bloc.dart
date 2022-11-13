
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serarching/src/core/error/failures.dart';
import 'package:serarching/src/features/posts/domain/use_cases/get_all_posts.dart';

import '../../../../../core/string/failure.dart';
import '../../../domain/entities/posts.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUseCase getAllPosts;

  PostBloc({required this.getAllPosts}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts =await getAllPosts.call();
        emit(mapFailureOrPostsToState(failureOrPosts)
        );
      } else if (event is RefreshPostEvent) {
        emit(LoadingPostsState());
        final failureOrPosts =await getAllPosts.call();
        emit(mapFailureOrPostsToState(failureOrPosts)
        );
      }
    });
  }

  PostState mapFailureOrPostsToState(Either<Failure,List<Post>> either){
  return   either.fold(
            (failure) =>ErrorPostsState(message: mapFailureMessage(failure)),
            (posts) =>LoadedPostsState(posts: posts),
    );
  }

  String mapFailureMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure :return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure :return OFFLINE_FAILURE_MESSAGE;

      default:return "Unexpected Error,please try again later";
    }
  }
}
