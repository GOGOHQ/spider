import 'package:flutter/material.dart';
import '../pages/change_theme_page.dart';
class MyDrawer extends StatelessWidget {
  // 菜单文本前面的图标大小
  static const double IMAGE_ICON_WIDTH = 30.0;
  // 菜单后面的箭头的图标大小
  static const double ARROW_ICON_WIDTH = 16.0;
  // 菜单后面的箭头图片
  var rightArrowIcon = Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );
  // 菜单的文本
  List menuTitles = ['设置主题色', '浏览历史', '禁用消息提示'];
  // 菜单文本前面的图标
  List menuIcons = [
    'images/ic_xiaoheiwu.png',
    'images/ic_about.png',
    'images/ic_settings.png'
  ];
  // 菜单文本的样式
  TextStyle menuStyle = TextStyle(
    fontSize: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
    constraints: new BoxConstraints(maxWidth: 304.0),
      child: Material(
        elevation: 16.0,
        child: ListView.builder(
          itemCount: menuTitles.length * 2 + 1,
          itemBuilder: renderRow,
          padding: const EdgeInsets.all(0.0), 
        ),
      ),
    );
  }

  Widget getIconImage(path) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 6.0, 0.0),
      child: Image.asset(path, width: 28.0, height: 28.0),
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      // render cover image
      var img = Image.asset(
        './images/cover_img.jpg',
      );
      return Container(
        height: 304.0,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        child: img,
      );
    }
    // 舍去之前的封面图
    index -= 1;
    // 如果是奇数则渲染分割线
    if (index.isOdd) {
      return Divider();
    }
    // 偶数，就除2取整，然后渲染菜单item
    index = index ~/ 2;
    // 菜单item组件
    var listItemContent = Padding(
      // 设置item的外边距
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      // Row组件构成item的一行
      child: Row(
        children: <Widget>[
          // 菜单item的图标
          getIconImage(menuIcons[index]),
          // 菜单item的文本，需要
          Expanded(
            child: Text(
              menuTitles[index],
              style: menuStyle,
            )
          ),
          rightArrowIcon
        ],
      ),
    );

    return InkWell(
      child: listItemContent,
      onTap: () {
        switch (index) {
          case 0:
            // 设置颜色
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return ChangeThemePage();
            }));
            break;
          case 1:
            // 浏览历史
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return Text('1');
            }));
            break;
          case 2:
            // 设置
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return Text('1');
            }));
            break;
        }
      },
    );
  }
}
