import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/post_detail/post_detail_store.dart';
import 'package:flutter/material.dart';
import 'package:minisocial/app/shared/utils/utils.dart';

import '../../shared/models/posts/post_model.dart';
import '../../shared/widgets/post_media_widget/post_media_widget.dart';

class PostDetailPage extends StatefulWidget {
  final String title;
  final PostModel post;
  const PostDetailPage({Key? key, this.title = 'PostDetailPage', required this.post})
    : super(key: key);
  @override
  PostDetailPageState createState() => PostDetailPageState();
}

class PostDetailPageState extends State<PostDetailPage> {
  final PostDetailStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.postModel = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        actions: [
          if (store.getUserId() == store.postModel.userId)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteDialog(post: widget.post);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(aspectRatio: 1, child: PostMediaWidget(post: store.postModel)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Postado ${Utils.formatTime(store.postModel.media!.metadata!.createdAt!)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                  future: Utils.getAddressFromLatLng(
                    lat: store.postModel.media!.metadata!.lat!,
                    lng: store.postModel.media!.metadata!.lng!,
                  ),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator();
                    }
                    if (!asyncSnapshot.hasData) {
                      return SizedBox();
                    }
                    return Text(
                      "local: ${asyncSnapshot.data!}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Observer(
                    builder: (context) {
                      return Text(
                        store.postModel.caption!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  if (store.getUserId() == store.postModel.userId)
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await showEditCaptionDialog(post: widget.post);
                      },
                    ),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Comentários",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder(
              future: store.getComments(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (asyncSnapshot.hasError) {
                  return Text("Erro ao carregar comentarios");
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: asyncSnapshot.data!.length,
                  itemBuilder: (_, index) {
                    final comment = asyncSnapshot.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(comment.userAvatar!.url!),
                      ),
                      title: Text(
                        comment.userName!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(comment.comment!),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog({required PostModel post}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Excluir post"),
          content: const Text("Tem certeza que deseja excluir este post?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),

            TextButton(
              onPressed: () async {
                await store.deletePost(postId: post.id!);
              },
              child: Observer(
                builder: (context) {
                  if (store.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return const Text("Excluir", style: TextStyle(color: Colors.red));
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future showEditCaptionDialog({required PostModel post}) async {
    final TextEditingController controller = TextEditingController(text: post.caption);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Digite o novo caption',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text != widget.post.caption!) {
                  store.updatePost(postId: post.id!, caption: controller.text);
                }
              },
              child: Observer(
                builder: (context) {
                  if (store.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return const Text('Salvar');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
