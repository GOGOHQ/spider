import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_spider/widgets/news_list_cell.dart';
import '../widgets/my_darwer.dart';
import '../widgets/news_head.dart';
import 'package:news_spider/util/data_utils.dart';
import 'package:news_spider/model/news_entity.dart';
import '../util/theme_utils.dart';
import '../constants/Constants.dart';
import '../events/ChangeThemeEvent.dart';
import '../widgets/reset_words.dart';
import '../events/change_words_event.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  TextEditingController _textEditingController;
  String mainWords;
  bool resetting = false;
  Color themeColor = ThemeUtils.currentColorTheme;
  List<newsEntity> newsData = <newsEntity>[];
  TextStyle mainWordsStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black);

  @override
  void initState() {
    _textEditingController = new TextEditingController();
    super.initState();
    getList();
    DataUtil.getColorThemeIndex().then((index) {
      print('color theme index = $index');
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        Constants.eventBus
            .fire(ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    Constants.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
    Constants.eventBus.on<ResetWordEvent>().listen((event) {
      setState(() {
        resetting = true;
      });
    });
  }

  getList() async {
    DataUtil.getNewsListData().then((result) {
      setState(() {
        newsData = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mainWords = mainWords == null ? '暂未设置' : mainWords;
    return MaterialApp(
        theme: new ThemeData(primaryColor: themeColor),
        home: new Scaffold(
            drawer: new MyDrawer(),
            appBar: new AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  icon: new Icon(Icons.settings),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              centerTitle: true,
              title: RichText(
                text: TextSpan(text: '关键字:',style:TextStyle(color: Colors.black), children: <TextSpan>[
                  TextSpan(text: '$mainWords', style: mainWordsStyle)
                ]),
              ),
              actions: <Widget>[
                ResetButton(),
              ],
            ),
            body: newsData.length > 0
                ? RefreshIndicator(
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      itemCount: newsData.length + 1,
                      itemBuilder: (context, index) =>
                          _renderList(context, index),
                    ),
                  )
                : CircularProgressIndicator()));
  }

  _renderList(context, index) {
    if (index == 0) {
      if (resetting) {
        return Column(children: [
          new Container(
              child: new Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: new BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.lightBlue),
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
                  ),
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: (String context) {
                      setState(() {
                        mainWords = context;
                        resetting = false;
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        icon: Icon(Icons.refresh),
                        hintText: "输入新关键字",
                        border: InputBorder.none),
                    textAlign: TextAlign.center,
                    autofocus: true,
                  ))),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NewsHead(newsCount: newsData.length),
                InkWell(
                  onTap: () {
                    onRefresh();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.refresh),
                      Text(
                        '刷新',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
        ]);
      } else {
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NewsHead(newsCount: newsData.length),
              InkWell(
                onTap: () {
                  onRefresh();
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.refresh),
                    Text(
                      '刷新',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
      }
    }

    return NewsListCell(Entity: newsData[index - 1]);
  }

  Future<void> onRefresh() async {
    newsData.clear();
    await getList();
  }
}
