import 'dart:async';
import 'dart:convert';
import 'package:movie/model/Data/Strings.dart';
import 'package:http/http.dart' as http;
class MovieRepository {
  Future<dynamic> fetchPosts (String part)async{
    var response=await http.get(Strings.mainUrl(part));
    if(response.statusCode==200){
      var data =json.decode(response.body);
      return data;
    }
  }
}