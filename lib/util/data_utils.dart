import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:news_spider/model/news_entity.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtil {
  static const String SP_COLOR_THEME_INDEX = "colorThemeIndex";
  static Future<String> _loadNewsListAsset() async {
    return await rootBundle.loadString('asset/data.json');
  }

  static Future<List<newsEntity>> getNewsListData() async {
    List<newsEntity> resultList = new List();
    String jsonString = await _loadNewsListAsset();
    final responseList = json.decode(jsonString)['items'];
    // var response = await NetUtils.get(Api.PINS_LIST, params: params);
    // var responseList = response['d']['list'];
    for (int i = 0; i < responseList.length; i++) {
      newsEntity entity;
      try {
        entity = newsEntity.fromJson(responseList[i]);
      } catch (e) {
        print("error $e at $i");
        continue;
      }
      resultList.add(entity);
    }
    return resultList;
  }

  // 设置选择的主题色
  static setColorTheme(int colorThemeIndex) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(SP_COLOR_THEME_INDEX, colorThemeIndex);
  }

  static Future<int> getColorThemeIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(SP_COLOR_THEME_INDEX);
  }
}
