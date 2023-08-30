import 'package:flutter/material.dart';
import 'package:themimictrial/state/image_upload/models/file_type.dart';
import 'package:themimictrial/state/posts/models/post.dart';
import 'package:themimictrial/views/components/post/post_image_view.dart';
import 'package:themimictrial/views/components/post/post_video_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return post.fileType == FileType.image
        ? PostImageView(post: post)
        : PostVideoView(post: post);
  }
}
