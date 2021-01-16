import 'package:flutter/material.dart';

class Post {
  final String id;
  final String postId;
  final String postContant;
  final String postTime;
  

  Post(
      {@required this.id,
        @required this.postId,
      @required this.postContant,
      @required this.postTime,});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      id: json['id'],
      postId: json['post_id'],
      postContant: json['post_contant'],
      postTime: json['post_time']);
      
   Map<String, dynamic> toJson() => {
        
        "post_id": postId,
        "post_contant" : postContant,
        "post_time": postTime,

      };
}
