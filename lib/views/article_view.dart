import 'dart:async';

import 'package:daily_news/loadingBar/loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;

  ArticleView({this.blogUrl});

  ///constructor

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  bool _loading = true;

  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wait();
  }
  
  wait() async{
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Daily"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        actions: [
          Container(
            child: IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.transparent,
              ),
            ),
          )
        ],
      ),
      body: _loading
          ? Center(
              child: Container(
                child: circleSpin(),
              ),
            )
          : Container(
              child: WebView(
                initialUrl: widget.blogUrl,
                onWebViewCreated: ((WebViewController webViewController) {
                  _completer.complete(webViewController);
                }),
              ),
            ),
    );
  }
}
