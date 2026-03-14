import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minisocial/app/modules/home/pages/create_post/create_post_store.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class CreatePostPage extends StatefulWidget {
  final String title;
  const CreatePostPage({Key? key, this.title = 'Novo Post'}) : super(key: key);
  @override
  CreatePostPageState createState() => CreatePostPageState();
}

class CreatePostPageState extends State<CreatePostPage> {
  final CreatePostStore store = Modular.get();
  PageController pageController = PageController(initialPage: 0);
  GlobalKey<FormBuilderState> formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    store.loadGallery();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (store.page == 1) {
          store.changePage(value: 0);
          pageController.previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                Observer(
                  builder: (_) {
                    return TextButton(
                      onPressed: store.isLoading
                          ? null
                          : () async {
                              if (store.page == 0) {
                                store.changePage(value: 1);
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              }

                              if (store.page == 1) {
                                if (formkey.currentState != null &&
                                    formkey.currentState!.saveAndValidate()) {
                                  await store.createPost(
                                    caption: formkey.currentState!.value['caption'],
                                  );
                                }
                              }
                            },
                      child: Text(store.page == 0 ? "Avançar" : "Publicar"),
                    );
                  },
                ),
              ],
            ),
            body: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.4,
                      width: constraints.maxWidth,
                      child: Observer(
                        builder: (context) {
                          if (store.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (store.selected == null) {
                            return const SizedBox();
                          }
                          return FutureBuilder(
                            future: store.selected!.file,
                            builder: (_, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              }

                              return Image.file(snapshot.data!, fit: BoxFit.cover);
                            },
                          );
                        },
                      ),
                    ),

                    Expanded(
                      child: Observer(
                        builder: (context) {
                          return GridView.builder(
                            itemCount: store.gallery.length + 1,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            itemBuilder: (_, index) {
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: store.takePhoto,
                                  child: Container(
                                    color: Colors.black12,
                                    child: const Icon(Icons.camera_alt, size: 30),
                                  ),
                                );
                              }

                              final asset = store.gallery[index - 1];

                              return GestureDetector(
                                onTap: () => store.selectImage(asset),
                                child: FutureBuilder(
                                  future: asset.thumbnailDataWithSize(
                                    const ThumbnailSize(200, 200),
                                  ),
                                  builder: (_, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox();
                                    }

                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilder(
                    key: formkey,
                    child: Column(
                      children: [
                        Observer(
                          builder: (_) {
                            if (store.selected == null) {
                              return const SizedBox();
                            }

                            return FutureBuilder(
                              future: store.selected!.file,
                              builder: (_, snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                }

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    snapshot.data!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        FormBuilderTextField(
                          name: "caption",
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: "Escreva uma legenda...",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "campo Obrigatório";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        Observer(
                          builder: (_) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: store.isLoading
                                    ? null
                                    : () async {
                                        if (formkey.currentState!.saveAndValidate()) {
                                          await store.createPost(
                                            caption:
                                                formkey.currentState!.value['caption'],
                                          );
                                        }
                                      },
                                child: store.isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text("Publicar"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
