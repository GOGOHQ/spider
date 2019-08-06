import 'package:flutter/material.dart';
import 'package:news_spider/model/news_entity.dart';
import '../pages/news_detail_page.dart';
class NewsListCell extends StatelessWidget {
  newsEntity Entity;
  NewsListCell({this.Entity});
  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: (){
         Navigator.push( context,
           new MaterialPageRoute(builder: (context) {
                  return new ArticleDetail(Entity.url, Entity.title);
             }));
      },
      child:
    new Card(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              Entity.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Text(Entity.detailWords),
              ),
              Icon(Icons.timer),
              Text(Entity.time),
             
              
            ],
          ),
          SizedBox(height: 10.0,)
        ],
      ),
    ));
  }
}
