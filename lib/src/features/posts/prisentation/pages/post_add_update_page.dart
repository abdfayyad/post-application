import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serarching/src/core/widgte/loading_widgte.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/pages/posts_page.dart';
import 'package:serarching/src/core/util/snack_bar_message.dart';

import '../../domain/entities/posts.dart';
import '../widgets/post_add_update/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post ?post;
 final bool isUpdatePost;

  const PostAddUpdatePage({Key? key,this.post,required this.isUpdatePost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBar(context),
     body: _body(context),
    );
  }
  AppBar _appBar(BuildContext context)=> AppBar(
    backgroundColor: Colors.teal,
    title: Text(isUpdatePost?"Update post":"Add post"),
    centerTitle: true,
  );
  Widget _body(BuildContext context){
    return Center(
      child: BlocConsumer<AddUpdateDeletePostBloc,AddUpdateDeletePostState>(
        listener: (context,state){
          if(state is MessageAddUpdateDeletePostState){
           SnackBarMessage().showSuccessSnackBar(context:context,message: state.message);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>PostsPage()), (route) => false);
          }else if(state is ErrorAddUpdateDeletePostState){
            SnackBarMessage().showErrorSnackBar(context:context,message:state.message);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>PostsPage()), (route) => false);

          }
        },
        builder: (context ,state){
         if(state is LoadingAddUpdateDeletePostState){
           return LoadingWidget();
         }

          return FormWidget(isUpdatePost:isUpdatePost,post:isUpdatePost?post:null);
        },
      ),
    );
  }

}
