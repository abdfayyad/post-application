import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:serarching/src/core/error/exception.dart';
import 'package:serarching/src/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

//this class that I implements it when I want  use any package for ex. http or dio.....
abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> addPost(PostModel postModel);

  Future<Unit> updatePost(PostModel postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(BASE_URL + "/posts/"),
        headers: {"Content_Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse(BASE_URL + "/Posts/${postId.toString()}"),
        headers: {"Content_Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async{
   final postId=postModel.id.toString();
   final body ={
     "title":postModel.title,
     "body":postModel.body,
    };
    final response=await client.patch(Uri.parse(BASE_URL+"/posts/${postId}"),body: body);
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
}
