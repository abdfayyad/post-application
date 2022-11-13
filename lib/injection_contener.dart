import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:serarching/src/core/network/netword_info.dart';
import 'package:serarching/src/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:serarching/src/features/posts/data/data_sources/post_remot_data_source.dart';
import 'package:serarching/src/features/posts/data/repositiories/post_repository_impl.dart';
import 'package:serarching/src/features/posts/domain/repositiories/post_repositiories.dart';
import 'package:serarching/src/features/posts/domain/use_cases/add_post.dart';
import 'package:serarching/src/features/posts/domain/use_cases/delete_posts.dart';
import 'package:serarching/src/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:serarching/src/features/posts/domain/use_cases/update_post.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/posts/post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
final sl=GetIt.instance;
Future<void> init()async{
  //Feature Post

  //Bloc
sl.registerFactory(() => PostBloc(getAllPosts: sl()));
sl.registerFactory(() => AddUpdateDeletePostBloc(
    addPost: sl(),
  updatePost: sl(),
  deletePost: sl(),
),);
  //Use Cases
sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
sl.registerLazySingleton(() => AddPostsUseCase(sl()));
sl.registerLazySingleton(() => DeletePostsUseCase(sl()));
sl.registerLazySingleton(() => UpdatePostsUseCase(sl()));
//Repository
sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(
    postRemoteDataSource: sl(),
    postLocalDataSource: sl(),
    networkInfo: sl()));
//Data source
sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(sharedPreferences: sl()));
//core
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//External
  final sharedPreferences=await SharedPreferences.getInstance();
sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}