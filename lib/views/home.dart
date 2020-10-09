import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_news/helper/data.dart';
import 'package:daily_news/helper/news.dart';
import 'package:daily_news/loadingBar/loading.dart';
import 'package:daily_news/model/article_model.dart';
import 'package:daily_news/model/category_model.dart';
import 'package:daily_news/views/article_view.dart';
import 'package:daily_news/views/category_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categories = getCategory();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
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
      ),
      body: _loading
          ? Center(
              child: Container(
                child: circleSpin(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    ///Categories....
                    Container(
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),

                    ///Blogs....
                    Container(
                      //height: MediaQuery.of(context).size.height, ///it takes whole display size
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*.80, ///it takes 80% of display size
                      padding: EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(), ///to smooth the scrolling
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

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryView(category: categoryName.toLowerCase(),headline: categoryName,)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: circleSpin(),
                  width: 50.0,
                  height: 50.0,
                ),
                width: 120.0,
                height: 60.0,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url,)));
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
            SizedBox(height: 8.0,),
            //Image.network(imageUrl),
            Text(title, style: TextStyle(
              fontSize: 18.0,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),),
            Text(desc, style: TextStyle(
              color: Colors.grey[700]
            ),),
          ],
        ),
      ),
    );
  }
}
