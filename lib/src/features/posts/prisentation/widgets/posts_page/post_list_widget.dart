import 'package:flutter/material.dart';
import 'package:serarching/src/features/posts/prisentation/pages/post_details_page.dart';

import '../../../domain/entities/posts.dart';

class PostListWidget extends StatelessWidget {
  final List<Post>posts;
  const PostListWidget({Key? key,required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(

        separatorBuilder: (context,index)=>Divider(thickness: 1),
        itemCount:posts.length,
      itemBuilder: (context,index){
          return ListTile(
            leading: Text(posts[index].id.toString()),
          title: Text(posts[index].title,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),),
          subtitle: Text(posts[index].body,style: TextStyle(fontSize: 16),),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>PostDetailPage(post: posts[index])));
            },
          );
      },
    );
  }
}
