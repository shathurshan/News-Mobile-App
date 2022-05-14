import 'dart:convert';

import 'package:api_new_project/Constance/strings.dart';
import 'package:api_new_project/Models/newsinfo.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  Future<Welcome> getNews() async {
    var client = http.Client();
    // ignore: prefer_typing_uninitialized_variables
    var newsModel;
    http.Response response;

    try {
      response = await http.get(ApiUrl.url);
      // ignore: unrelated_type_equality_checks
      if (response.statusCode == 200) {
        var jsonSring = response.body;
        var jsonMap = json.decode(jsonSring);
        newsModel = Welcome.fromJson(jsonMap);
        //   newsModel.articles.forEach((element) {
        //     print(element.author);
        //   });
      }
    } catch (Exception) {
      print("error1234");
    }
    return newsModel;
  }
}
