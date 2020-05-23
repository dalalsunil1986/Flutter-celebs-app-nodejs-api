import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  final dynamic item;

  DetailScreen({this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              SizedBox(height: 40,),

              ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Hero(
                  tag: item["image"],
                  child: Container(
                    width: 300,
                    height: 300,
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
              ),

              SizedBox(height: 20,),

              Text(item["name"]),

              SizedBox(height: 20,),

              Text(item["descripton"]),


            ],
          ),
        ),
      ),
    );
  }
}