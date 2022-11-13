import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;

  const DeleteDialogWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are You Sure'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No')),
        TextButton(
            onPressed: () {
              BlocProvider.of<AddUpdateDeletePostBloc>(context)
                  .add(DeletePostEvent(postId: postId));
            },
            child: const Text('Yes'))
      ],
    );
  }
}