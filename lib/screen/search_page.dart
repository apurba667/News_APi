import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:provider/provider.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Articles> searchList=[];
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Screen"),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(child: 
          Column(
            children: [
              Text("Search Here"),
              TextField(
                onEditingComplete: ()async{
                  searchList =await searchProvider.getSearchData(query: controller.text);
                },
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search"
                ),
              ),
              MaterialButton(onPressed: ()async{
                searchList =await searchProvider.getSearchData(query: controller.text);
                setState(() {

                });
              },
                color: Colors.blue,
                height: 40,
              child: Text("Submit"),
              ),
              ListView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                shrinkWrap: true,
                  itemCount: searchList.length,
                  itemBuilder: (context,index){
                return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                          "${searchList![index].urlToImage}",
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
                                              "${searchList![index].source!.name}"),
                                          Text("${searchList![index].title}"),
                                          Text("${searchList![index].publishedAt}")
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
                    );

              })
            ],
          ),),
      ),
    );
  }
}
