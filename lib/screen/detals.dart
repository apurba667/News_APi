import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:provider/provider.dart';
class NewsDetails extends StatelessWidget {
  static String routeName = "newsDetails";
  const NewsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var publishAt = ModalRoute.of(context)!.settings.arguments as String;
    var currentData = Provider.of<NewsProvider>(context).findByDate();
    return Scaffold(
      appBar: AppBar(
        title: Text("${currentData.author}"),
      ),
    );
  }
}
