import 'package:flutter/material.dart';
import 'package:news_spider/pages/app.dart';

class NewsHead extends StatelessWidget {
  int newsCount;
 

  NewsHead({this.newsCount});
  @override
  Widget build(BuildContext context) {
      return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 0.1),
          new Text(
            '新闻条数:$newsCount',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          // new Container(
          //     width: 200,
          //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //     decoration: new BoxDecoration(
          //       border: Border.all(width: 1.0, color: Colors.lightBlue),
          //       color: Colors.white,
          //       borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          //     ),
          //     child: TextField(
          //       cursorColor: Colors.white,
          //       decoration: InputDecoration(
          //         contentPadding: EdgeInsets.all(11.0),
          //         icon: Icon(Icons.refresh),
          //         hintText: "搜索",
          //         border: InputBorder.none
          //       ),

          //       textAlign: TextAlign.center,
          //       autofocus: true,
          //     ))
        ],
      
    );
  }
}
