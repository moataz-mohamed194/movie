import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Data/Strings.dart';

class MovieRepository {
  Future<dynamic> fetchPosts(String part) async {
    var response = await http.get(Strings.mainUrl(part));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    }
  }
}
