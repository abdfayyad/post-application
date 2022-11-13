part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable{
  const PostState();
  @override
  List<Object> get props =>[];
}

class PostInitial extends PostState {}

class LoadingPostsState extends PostState{}
class LoadedPostsState extends PostState{
  final List<Post>posts;

  LoadedPostsState({required this.posts});
  @override
  List<Object> get props =>[posts];
}
class ErrorPostsState extends PostState{
  final String message;

  ErrorPostsState({required this.message});
  @override
  List<Object> get props =>[message];
}