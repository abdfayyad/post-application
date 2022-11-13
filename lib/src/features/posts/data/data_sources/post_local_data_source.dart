import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:serarching/src/core/error/exception.dart';
import 'package:serarching/src/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
//this class that I implements it when I want  use any package for ex. http or dio.....
abstract class PostLocalDataSource{
  Future<List<PostModel>>getCachePosts();
Future<Unit>cachePosts(List<PostModel> postModel);

}
class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PostModel>> getCachePosts() {
    final jsonString=sharedPreferences.getString("CACHED_POSTS");
    if (jsonString !=null){
      List decodeJsonData=json.decode(jsonString);
      List <PostModel>jsonToPostModel=decodeJsonData.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
   return Future.value(jsonToPostModel);
    }else{
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelToJson=postModels.map<Map<String,dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString("CACHED_POSTS", json.encode(postModelToJson));
    return Future.value(unit);

  }



}
