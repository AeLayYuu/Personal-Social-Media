import 'package:flutter/material.dart';

class PostPhoto {
  final String id;
  final String postImageId;
  final String postImage;
  final String postImagePath;

  PostPhoto({
    @required this.id,
    @required this.postImageId,
    @required this.postImage,
    @required this.postImagePath,
  });

  factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
      id: json['id'],
      postImageId: json['post_image_id'],
      postImage: json['post_image'],
      postImagePath: json['post_image_path']);

  Map<String, dynamic> toJson() => {
        "post_image_id": postImageId,
        "post_image": postImage,
        "post_image_path": postImagePath,
      };
}
