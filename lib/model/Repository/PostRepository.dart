import 'dart:async';
import 'dart:convert';
import 'package:movie/model/Data/Strings.dart';
import '../models/PostModel.dart';
import 'package:http/http.dart' as http;
class PostRepository {
  Future<List<Results>> fetchPosts (String part)async{
    var response=await http.get(Strings.mainUrl(part));
    if(response.statusCode==200){
      var data =json.decode(response.body);
      List<Results> posts;

      // posts.clear();
      posts=MovieModel.fromJson(data).results;
      print(".........................");
      print(data);
      print(".........................");
      return posts;
    }
  }
}