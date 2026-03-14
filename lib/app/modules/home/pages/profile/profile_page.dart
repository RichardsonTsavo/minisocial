import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/home/pages/profile/profile_store.dart';
import 'package:flutter/material.dart';
import 'package:minisocial/app/shared/models/posts/post_model.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key? key, this.title = 'Perfil'}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ProfileStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width > 600 ? 4 : 3;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: constraints.maxWidth * 0.1,
                          backgroundImage: store.getAvatar() != null
                              ? NetworkImage(store.getAvatar()!.url!)
                              : null,
                          child: store.getAvatar() == null
                              ? Text(
                                  store
                                      .getName()
                                      .split(' ')
                                      .map((e) => e[0])
                                      .take(2)
                                      .join()
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              profileStat(
                                value: store.getPostsCount().toString(),
                                label: "Posts",
                              ),

                              profileStat(
                                value: store.getFollowersCount().toString(),
                                label: "Seguidores",
                              ),

                              profileStat(
                                value: store.getFollowingCount().toString(),
                                label: "Seguindo",
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            store.logout();
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.getUsername(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(store.getBio()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text("Editar perfil"),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(),
                  FutureBuilder(
                    future: store.getMyPosts(),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: asyncSnapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (_, index) {
                          PostModel postModel = asyncSnapshot.data![index];
                          return GestureDetector(
                            onTap: () async {
                              await Modular.to.pushNamed(
                                "/post_detail",
                                arguments: postModel,
                              );
                              setState(() {});
                            },
                            child: Image.network(
                              postModel.media!.url!.replaceAll(
                                "http://localhost:8080/",
                                "http://10.0.2.2:8080/",
                              ),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget profileStat({required String value, required String label}) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label),
      ],
    );
  }
}
