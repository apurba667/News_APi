import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/screen/detals.dart';
import 'package:newsapp/screen/search_page.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> NewsProvider()),
      ],
      child: MaterialApp(
        routes: {
          NewsDetails.routeName:(context)=>NewsDetails(),
        },
      debugShowCheckedModeBanner: false,
        home: SearchPage(),
      ),
    );
  }
}
