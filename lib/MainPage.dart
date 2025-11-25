import 'package:dictionary/model/post.dart';
import 'package:dictionary/services/remoteservices.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      posts = await Remoteservices().getPosts();
    } catch (e) {
      // İstersen burada errorMessage tutabilirsin
      posts = [];
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = posts ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dictionary"),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: data.isEmpty
            ? const Center(child: Text('Hiç kelime bulunamadı'))
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final post = data[index];
                  final meanings = post.meanings ?? [];
                  final licenseName = post.license?.name;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kelime
                        Text(
                          post.word,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),

                        // Meanings
                        ...meanings.map((meaning) {
                          final definitions = meaning.definitions ?? [];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Part of Speech
                                Text(
                                  meaning.partOfSpeech ?? 'No Type',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                  ),
                                ),

                                // Definitions
                                ...definitions.asMap().entries.map((entry) {
                                  final definitionIndex = entry.key + 1;
                                  final definition = entry.value;

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      top: 5.0,
                                    ),
                                    child: Text(
                                      '$definitionIndex. ${definition.definition}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }).toList(),

                        // License (sadece 1 kere)
                        if (licenseName != null && licenseName.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              'License: $licenseName',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),

                        const Divider(thickness: 2, height: 20),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
