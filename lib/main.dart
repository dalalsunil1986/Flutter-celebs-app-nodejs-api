import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:celebs_api_flutter_app/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String api = "https://celebs-api-nodejs.herokuapp.com/celebs";

  bool isLoaded = false;
  List data;

  @override
  void initState() { 
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await http.get(api);
    print(response.body);
    setState(() {
      data = jsonDecode(response.body);
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Celebs", style: TextStyle(color: Colors.black,),),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: isLoaded != false ? Container(

        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: data.map((item){
            return InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx)=>DetailScreen(
                      item: item,
                    )
                  ),
                );
              },
              child: Hero(
                tag: item["image"],
                child: Container(
                  child: AspectRatio(
                    aspectRatio: 1/1,
                    child: CachedNetworkImage(
                      imageUrl: item["image"],
                      placeholder: (ctx,str)=>Text("Loading..."),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}