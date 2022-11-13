import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serarching/src/core/util/snack_bar_message.dart';
import 'package:serarching/src/core/widgte/loading_widgte.dart';
import 'package:serarching/src/features/posts/domain/entities/posts.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/pages/posts_page.dart';
import 'package:serarching/src/features/posts/prisentation/widgets/detail_page/update_post_btn_widget.dart';

import '../widgets/detail_page/delete_dialog_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text('Detail Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                post.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                height: 50,
              ),
              Text(
                post.body,
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UpdatePostBtnWidget(post: post),
                  ElevatedButton.icon(
                    onPressed: () => deleteDialog(context),
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color
                      // Text Color (Foreground color)
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeletePostBloc,
              AddUpdateDeletePostState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeletePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    context: context, message: state.message);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddUpdateDeletePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    context: context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddUpdateDeletePostState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              } else
                return DeleteDialogWidget(postId: post.id!);
            },
          );
        });
  }
}
