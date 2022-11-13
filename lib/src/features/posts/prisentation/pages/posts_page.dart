import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/posts/post_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/pages/post_add_update_page.dart';

import '../../../../core/widgte/loading_widgte.dart';

import '../widgets/posts_page/message_display_widget.dart';
import '../widgets/posts_page/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBar(),
      body: _buildBody(),
      floatingActionButton: _floatingActionButton(context),
    );
  }
  AppBar _appBar()=>AppBar(
    title: Text("Posts"),
  centerTitle: true,
    backgroundColor: Colors.teal,
  );
  Widget _buildBody() {
    return Padding(padding: const EdgeInsets.all(8.0),
    child: BlocBuilder<PostBloc,PostState>(
      builder: (context,state){
      if(state is LoadingPostsState){
        return LoadingWidget();
      }else if (state is LoadedPostsState){
        return RefreshIndicator(
            onRefresh:()=> _onRefresh(context),
            child: PostListWidget(posts: state.posts,));
      }else if(state is ErrorPostsState){
        return MessageDisplayWidget(message:state.message);
      }
      return LoadingWidget();
      },
    ),
    );
  }
  Widget _floatingActionButton(BuildContext context){
    return FloatingActionButton(
      onPressed: (){
       Navigator.push(context,MaterialPageRoute(builder: (context)=>PostAddUpdatePage(isUpdatePost: false)));
      },
      child: Icon(Icons.add),
    backgroundColor: Colors.teal,
    );
  }
 Future<void> _onRefresh(BuildContext context)async{
    BlocProvider.of<PostBloc>(context).add(RefreshPostEvent());
  }
}

