import 'package:dartz/dartz.dart';
import 'package:serarching/src/features/posts/domain/repositiories/post_repositiories.dart';

import '../../../../core/error/failures.dart';

class DeletePostsUseCase{
  final PostsRepository repository;

  DeletePostsUseCase(this.repository);
  Future<Either<Failure,Unit>> call(int postId)async{
    return await repository.deletePost(postId);
  }
}