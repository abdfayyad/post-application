import 'package:dartz/dartz.dart';
import 'package:serarching/src/features/posts/domain/repositiories/post_repositiories.dart';

import '../../../../core/error/failures.dart';
import '../entities/posts.dart';

class GetAllPostsUseCase{
  final PostsRepository repository;

  GetAllPostsUseCase(this.repository);
  Future<Either<Failure,List<Post>>> call()async {
    return await repository.getAllPosts();
  }

}