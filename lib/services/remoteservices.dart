import 'package:dictionary/model/post.dart';
import 'package:http/http.dart' as http;

class Remoteservices {
  Future<List<Post>? > getPosts() async {
    try { // Hata izlemeyi başlat
      var client = http.Client();
      var uri = Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/dog/");
      var response = await client.get(uri);
      
      if(response.statusCode == 200){
        var json = response.body;
        return postFromJson(json);
      }
      // 200 değilse null döndürür (veya bir hata fırlatılabilir)
      return null;
    } catch (e) {
      // Hata oluşursa (örneğin bağlantı koparsa)
      print('HTTP İstek Hatası: $e'); 
      return null;
    }
  }
}