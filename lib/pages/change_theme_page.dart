import 'package:flutter/material.dart';
import 'package:news_spider/pages/app.dart';
import '../constants/Constants.dart';
import '../events/ChangeThemeEvent.dart';
import '../util/data_utils.dart';
import '../util/theme_utils.dart';

class ChangeThemePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangeThemePageState();
}

class ChangeThemePageState extends State<ChangeThemePage> {

  List<Color> colors = ThemeUtils.supportColors;

  changeColorTheme(Color c) {
    Constants.eventBus.fire(ChangeThemeEvent(c));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('切换主题', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.count(
          crossAxisCount: 4,
          children: List.generate(colors.length, (index) {
            return InkWell(
              onTap: () {
                ThemeUtils.currentColorTheme = colors[index];
                DataUtil.setColorTheme(index);
                changeColorTheme(colors[index]);
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return MyApp();}));
                
              },
              child: Container(
                color: colors[index],
                margin: const EdgeInsets.all(3.0),
                // decoration: new BoxDecoration(
                //   border: new Border.all(width: 1.0)
                // ),
              ),
            );
          }),
        )
      )
    );
  }

}