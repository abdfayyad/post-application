import 'package:dartz/dartz.dart';
import 'package:serarching/src/core/error/exception.dart';
import 'package:serarching/src/core/error/failures.dart';
import 'package:serarching/src/core/network/netword_info.dart';
import 'package:serarching/src/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:serarching/src/features/posts/data/data_sources/post_remot_data_source.dart';
import 'package:serarching/src/features/posts/data/models/post_model.dart';
import 'package:serarching/src/features/posts/domain/entities/posts.dart';
import 'package:serarching/src/features/posts/domain/repositiories/post_repositiories.dart';
typedef Future<Unit> DeleteOrUpdateOrAddPost();
class PostRepositoryImpl extends PostsRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.postRemoteDataSource,
      required this.postLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCachePosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel( title: post.title, body: post.body);
    return await getMassage(() {
      return postRemoteDataSource.addPost(postModel);
    } );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId)async {
  return await getMassage(() {
    return postRemoteDataSource.deletePost(postId);
  });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post)async {
    final PostModel postModel =
    PostModel(id: post.id, title: post.title, body: post.body);
   return await getMassage(() {
     return postRemoteDataSource.updatePost(postModel);
   } );
  }
  Future<Either<Failure, Unit>>getMassage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost )async{
    if (await networkInfo.isConnected) {
      try {
        // await postRemoteDataSource.updatePost(postModel);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
}
