import 'package:flutter/material.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/service/news_api_service.dart';
import 'package:provider/provider.dart';


class NewsProvider with ChangeNotifier{
  List<Articles> newsList =[];
  List<Articles> searchList=[];
  Future<List<Articles>> getNewsData({required int page,required String sortBy}) async{
  newsList =   await NewsApiService.fetchNewsData(page: page, sortBy: sortBy);
  return newsList;
  }

  Articles findByDate({String ?date}){
  Articles data =  newsList.firstWhere((element) => element.publishedAt == date);
    return data;
  }

  Future<List<Articles>> getSearchData({required String query}) async{
    searchList =   await NewsApiService.fetchSearchData(query: query);
    notifyListeners();
    return searchList;
  }

}
