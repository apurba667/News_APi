import 'package:flutter/material.dart';
import 'package:newsapp/const/const.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/screen/detals.dart';
import 'package:newsapp/screen/search_page.dart';
import 'package:newsapp/service/news_api_service.dart';
import 'package:newsapp/widget/news_enum.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  String sortBy = NewsEnum.popularity.name;

 /* List<Articles> newsList = [];

  @override
  void didChangeDependencies() async{
    newsList = await NewsApiService().fetchNewsData();
    super.didChangeDependencies();
    setState(() {

    });
  }*/
  @override
  Widget build(BuildContext context) {

    final providerData = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("News Aapp"),
        actions: [ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage()));
        }, child: Icon(Icons.search))],
      ),
      body:SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "All News",
                  style: myStyle(22, Colors.black),
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: () {
                        if(currentIndex >=2){
                          currentIndex = currentIndex-1;
                          setState(() {

                          });
                        }
                      }, child: Text("Prev")),
                      Flexible(
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = index + 1;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                color: currentIndex == index + 1
                                    ? Colors.blue
                                    : Colors.white,
                                width: 35,
                                height: 30,
                                child: Text("${index + 1}"),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(onPressed: () {
                        if(currentIndex <=4){
                          currentIndex = currentIndex+1;
                          setState(() {

                          });
                        }
                      }, child: Text("Next")),
                    ],
                  ),
                ),
                DropdownButton<String>(
                    value: sortBy,
                    items: [
                  DropdownMenuItem(child: Text("${NewsEnum.popularity.name}"),
                  value: NewsEnum.popularity.name,
                  ),
                  DropdownMenuItem(child: Text("${NewsEnum.relevancy.name}"),
                    value: NewsEnum.relevancy.name,
                  ),
                  DropdownMenuItem(child: Text("${NewsEnum.publishedAt.name}"),
                    value: NewsEnum.publishedAt.name,
                  ),
                ], onChanged: (value){
                  setState(() {
                    sortBy = value!;
                  });
                }),
                FutureBuilder<List<Articles>>(
                  /*future: NewsApiService.fetchNewsData(page: currentIndex,sortBy: sortBy),*/
                  future: providerData.getNewsData(page: currentIndex, sortBy: sortBy),
                  
                  builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }
                  else if (snapshot.hasError){
                    return Container(
                      child: Text("Something is wrong Please Try again"),
                    );
                  }
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, NewsDetails.routeName,arguments: snapshot.data?[index].publishedAt);
                            },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              "${snapshot.data![index].urlToImage}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                  "${snapshot.data![index].source!.name}"),
                                              Text("${snapshot.data![index].title}"),
                                              Text("${snapshot.data![index].publishedAt}")
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  child: Container(
                                    height: 8,
                                    width: 60,
                                    color: Colors.blueAccent,
                                  )),
                              Positioned(
                                  child: Container(
                                    height: 60,
                                    width: 8,
                                    color: Colors.blueAccent,
                                  )),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 60,
                                    width: 8,
                                    color: Colors.blueAccent,
                                  )),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 8,
                                    width: 60,
                                    color: Colors.blueAccent,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
