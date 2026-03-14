import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:minisocial/app/shared/models/posts/comment_model.dart';

import '../../../../shared/enums/post_type.dart';
import '../../../../shared/models/posts/post_model.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/post_media_widget/post_media_widget.dart';
import 'post_card_store.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onShare;
  final VoidCallback? onSave;

  const PostCard({super.key, required this.post, this.onLike, this.onShare, this.onSave});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PostCardStore store = PostCardStore();

  @override
  void initState() {
    super.initState();
    store.post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(store.post.userAvatar!.url!),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      store.post.userName!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  if (store.postedByMe()) const Icon(Icons.more_vert),
                ],
              ),
            ),
            AspectRatio(aspectRatio: 1, child: PostMediaWidget(post: store.post)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                spacing: 12,
                children: [
                  Observer(
                    builder: (context) {
                      return InkWell(
                        onTap: () {
                          store.like();
                          widget.onLike?.call();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              store.post.likedByMe!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: store.post.likedByMe! ? Colors.red : null,
                              size: 28,
                            ),
                            Text(
                              "${store.post.likedByMe! ? (store.post.likesCount! + 1) : store.post.likesCount}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => FutureBuilder<List<CommentModel>>(
                              future: store.getComments(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Erro ao carregar comentarios");
                                }
                                return DraggableScrollableSheet(
                                  expand: false,
                                  initialChildSize: 0.7,
                                  minChildSize: 0.4,
                                  maxChildSize: 0.95,
                                  builder: (context, scrollController) => Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          height: 4,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),

                                        const Text(
                                          "Comentários",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),

                                        const Divider(),
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting)
                                          Center(child: CircularProgressIndicator())
                                        else
                                          Expanded(
                                            child: ListView.builder(
                                              controller: scrollController,
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (_, index) {
                                                final comment = snapshot.data![index];

                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                      comment.userAvatar!.url!,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    comment.userName!,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(comment.comment!),
                                                );
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: const Icon(Icons.mode_comment_outlined, size: 26),
                      ),
                      Text(
                        "${store.post.commentsCount}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  InkWell(onTap: () {}, child: const Icon(Icons.send_outlined, size: 26)),

                  const Spacer(),

                  Observer(
                    builder: (context) {
                      return InkWell(
                        onTap: () {
                          store.salve();
                          widget.onSave?.call();
                        },
                        child: Icon(
                          store.post.savedByMe! ? Icons.bookmark : Icons.bookmark_border,
                          size: 28,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Observer(
                builder: (context) {
                  return Text(
                    "${store.post.likedByMe! ? (store.post.likesCount! + 1) : store.post.likesCount} curtidas | ${store.post.commentsCount} comentários",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),

            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: "${store.post.userName} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: store.post.caption),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                Utils.formatTime(store.post.createdAt!),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
