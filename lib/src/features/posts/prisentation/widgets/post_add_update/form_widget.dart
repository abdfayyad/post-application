import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:serarching/src/features/posts/domain/entities/posts.dart';
import 'package:serarching/src/features/posts/prisentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;

  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }
void validateFromThenUpdateOrAddPost(){
    final isValid=formKey.currentState!.validate();
    print(titleController.text);
    print(bodyController.text);
    if(isValid){
      final post=Post(
          id: widget.isUpdatePost ? widget.post!.id:null,
          title: titleController.text,
          body: bodyController.text
      );
      if(widget.isUpdatePost){
        BlocProvider.of<AddUpdateDeletePostBloc>(context).add(UpdatePostEvent(post: post));
      }else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context).add(AddPostEvent(post: post));
      }
    }
}
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: titleController,
                validator: (val) =>
                  val!.isEmpty ? "Title Can't Be Empty " : null

                ,
                decoration: InputDecoration(
                  hintText: "Title",
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),

                  ),
              ),
            ),
            //textfield body
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: bodyController,
                  validator: (val) =>
                    val!.isEmpty ? "Body Can't Be Empty " : null,

                  maxLines: 6,
                  minLines: 6,
                  decoration: InputDecoration(
                    hintText: "Body",
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                )),

            
            //submit btm(add-update)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Background color
                // Text Color (Foreground color)
              ),
                onPressed:validateFromThenUpdateOrAddPost ,
                icon: widget.isUpdatePost?Icon(Icons.edit):Icon(Icons.add),
                label: Text(widget.isUpdatePost?"Update":"Add"),


            ),
          ],
        ));
  }
}
