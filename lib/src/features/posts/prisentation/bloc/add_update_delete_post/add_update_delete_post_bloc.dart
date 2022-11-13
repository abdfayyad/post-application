

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:serarching/src/core/string/messages.dart';
import 'package:serarching/src/features/posts/domain/entities/posts.dart';
import 'package:serarching/src/features/posts/domain/use_cases/add_post.dart';
import 'package:serarching/src/features/posts/domain/use_cases/update_post.dart';
import 'package:serarching/src/features/posts/domain/use_cases/delete_posts.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/string/failure.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc extends
                Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {

  final AddPostsUseCase addPost;
  final UpdatePostsUseCase updatePost;
  final DeletePostsUseCase deletePost;
  AddUpdateDeletePostBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost}) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async{
      if(event is AddPostEvent){
emit(LoadingAddUpdateDeletePostState());
final failureOrMessage=await addPost(event.post);
        emit(eitherDoneMessageOrErrorState(failureOrMessage, ADD_SUCCESS_MESSAGE));
      }else if(event is UpdatePostEvent){
        emit(LoadingAddUpdateDeletePostState());
        final failureOrMessage=await updatePost(event.post);
       emit(eitherDoneMessageOrErrorState(failureOrMessage, UPDAT_SUCCESS_MESSAGE));
      }else if(event is DeletePostEvent){
        emit(LoadingAddUpdateDeletePostState());
        final failureOrMessage=await deletePost(event.postId);
        emit(eitherDoneMessageOrErrorState(failureOrMessage, DELETE_SUCCESS_MESSAGE));
      }

    });
  }
  AddUpdateDeletePostState eitherDoneMessageOrErrorState(Either<Failure,Unit>either,String message){
return either.fold((failure) =>
  ErrorAddUpdateDeletePostState(message: mapFailureMessage(failure)),
        (_) =>MessageAddUpdateDeletePostState(message: message)
);
  }
  String mapFailureMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:return SERVER_FAILURE_MESSAGE;
      case OfflineFailure :return OFFLINE_FAILURE_MESSAGE;

      default:return "Unexpected Error,please try again later";
    }
  }
}
