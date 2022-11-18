import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/news_model.dart';

class NewsApiService{
  static Future<List<Articles>> fetchNewsData({required int page,required String sortBy})async{
    List<Articles> newsList = [];
    try{
      var link =
          "https://newsapi.org/v2/everything?q=bitcoin&apiKey=ac087348e9aa4726acdb2c0583807ec1&pageSize=10&page=$page&sortBy=$sortBy";
      var responce = await http.get(Uri.parse(link));
      print("responce is ${responce.body}");
      var data = jsonDecode(responce.body);
      Articles articles;
      for (var i in data["articles"]) {
        articles = Articles.fromJson(i);
        newsList.add(articles);

      }
    }catch(e){
      print("$e");
    }
    return newsList;
  }
  static Future<List<Articles>> fetchSearchData({required String query})async{
    List<Articles> searchList = [];
    try{
      var link =
          "https://newsapi.org/v2/everything?q=$query&apiKey=ac087348e9aa4726acdb2c0583807ec1";
      var responce = await http.get(Uri.parse(link));
      print("responce is ${responce.body}");
      var data = jsonDecode(responce.body);
      Articles articles;
      for (var i in data["articles"]) {
        articles = Articles.fromJson(i);
        searchList.add(articles);

      }
    }catch(e){
      print("$e");
    }
    return searchList;
  }
}