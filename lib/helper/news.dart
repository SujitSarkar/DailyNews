import 'dart:convert';

import 'package:daily_news/model/article_model.dart';
import 'package:http/http.dart' as http;

//Api-Key: 8ff28c7eb05a4d728c0731a334e837ad

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=8ff28c7eb05a4d728c0731a334e837ad";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){

          ArticleModel articleModel = ArticleModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );

          news.add(articleModel);
        }
      });
    }
  }
}


class CategoryNews{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url = "http://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=8ff28c7eb05a4d728c0731a334e837ad";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){

          ArticleModel articleModel = ArticleModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );

          news.add(articleModel);
        }
      });
    }
  }
}
