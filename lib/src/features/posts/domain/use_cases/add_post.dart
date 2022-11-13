import 'package:dartz/dartz.dart';
import 'package:serarching/src/features/posts/domain/entities/posts.dart';
import 'package:serarching/src/features/posts/domain/repositiories/post_repositiories.dart';

import '../../../../core/error/failures.dart';

 class AddPostsUseCase{
  final PostsRepository repository;

  AddPostsUseCase(this.repository);
  Future<Either<Failure,Unit>>call (Post post)async{
    return await repository.addPost(post);
  }

}