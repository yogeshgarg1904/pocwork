import 'dart:convert';
//import 'dart:html';
import 'package:http/http.dart';
import 'post_model.dart';


class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Client client = Client();

  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.https("jsonplaceholder.typicode.com", "posts") );
    //esponse res = await client.get(Uri.https("jsonplaceholder.typicode.com", "posts/1"));

    if (res.statusCode == 200) {
      print('object');
      print(res.body);
      List<dynamic> body = jsonDecode(res.body);


      List<Post> posts = body
        .map(
          (dynamic item) => Post.fromJson(item),
        )
        .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}