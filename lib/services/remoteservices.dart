import 'package:dictionary/model/post.dart';
import 'package:http/http.dart' as http;

class Remoteservices {
  Future<List<Post>? > getPosts()async
  {
    var client = http.Client();

    var uri = Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/hello/");
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return postFromJson(json);
    }
  }
}