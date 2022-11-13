import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
  class Post extends Equatable{
    final int ?id;
    final String title;
    final String body;
  @override
  // TODO: implement props
  List<Object?> get props =>[id,title,body];

    Post({ this.id,required this.title,required this.body});
}