import 'package:dictionary/model/post.dart';
import 'package:dictionary/services/remoteservices.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List <Post>? posts;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    getData();
  }

  getData() async{
    posts = await Remoteservices().getPosts();
    if (posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dictionary"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                Text(posts![index].word)

              ],
            );
          }
        ),
        replacement: const CircularProgressIndicator(),
      )
    );
  }
}