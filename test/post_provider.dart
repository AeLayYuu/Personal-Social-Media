import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:social_media/model/post.dart';
import 'package:http/http.dart' as http;


class PostProvider with ChangeNotifier{

  String url = "http://localhost/social_media/insertData.php";
  List<Post> specificationList = [];
  Future<List<Post>> postProvider() async {
    print("reach function");
    final response = await http.get("$url");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("response data in specification $data");
      var dataList = data[''];
      if (dataList.length > 0) {
        specificationList = [];
        dataList.forEach((value) {
          Post spec = Post.fromJson(value);
          specificationList.add(spec);
        });
      }
      return specificationList;
    } else {
      throw Exception("Fail to load specification data");
    }
  }

}