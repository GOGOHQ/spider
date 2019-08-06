import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleDetail extends StatefulWidget {
  final String articleUrl;
  final String title;
  ArticleDetail(this.articleUrl, this.title);
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.articleUrl,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      withZoom: false,
      hidden: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
