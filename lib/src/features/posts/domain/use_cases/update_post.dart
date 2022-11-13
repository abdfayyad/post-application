import 'package:dartz/dartz.dart';
import 'package:serarching/src/features/posts/domain/entities/posts.dart';
import 'package:serarching/src/features/posts/domain/repositiories/post_repositiories.dart';

import '../../../../core/error/failures.dart';

class UpdatePostsUseCase{
  final PostsRepository repository;

  UpdatePostsUseCase(this.repository);
  Future<Either<Failure,Unit>>call (Post post)async{
    return await repository.updatePost(post);
  }

}