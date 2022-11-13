import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/posts/post_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/pages/posts_page.dart';

import 'injection_contener.dart'as di;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
BlocProvider(create: (_)=>di.sl<PostBloc>()..add(GetAllPostsEvent())),
BlocProvider(create: (_)=>di.sl<AddUpdateDeletePostBloc>()),


    ],
      child:  MaterialApp(
      title: "Post App",
      debugShowCheckedModeBanner: false,
      home:PostsPage()
    ),);
}}
