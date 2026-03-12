import 'package:flutter/material.dart';

import '../../enums/post_type.dart';
import '../../models/posts/post_model.dart';

class PostMediaWidget extends StatelessWidget {
  final PostModel post;
  const PostMediaWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    switch (post.type!) {
      case PostType.image:
        return Image.network(post.mediaUrl!, fit: BoxFit.cover, width: double.infinity);

      case PostType.video:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(color: Colors.black),
            const Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
          ],
        );
    }
  }
}
