import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_news/helper/news.dart';
import 'package:daily_news/loadingBar/loading.dart';
import 'package:daily_news/model/article_model.dart';
import 'package:flutter/material.dart';

import 'article_view.dart';

class CategoryView extends StatefulWidget {
  final String category;
  final String headline;

  CategoryView({this.category, this.headline});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews categoryNewsClass = CategoryNews();
    await categoryNewsClass.getNews(widget.category);
    articles = categoryNewsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.headline),
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
          : SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    ///Blogs....
                    Container(
                      //height: MediaQuery.of(context).size.height, ///it takes whole display size
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .90,
                      ///it takes 80% of display size
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),

                          ///to smooth the scrolling
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                            );
                          }),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: circleSpin(),
                  width: 150.0,
                  height: 150.0,
                ),
                //width: 300.0,
                // height: 60.0,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            //Image.network(imageUrl),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
