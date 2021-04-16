import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/track.dart';
import 'article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews('Business', 'nl');
  }

  getNews(String category, String country) async {
    News newsClass = News(category: category, country: country);
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    /// Categories
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      height: 70.0,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              getNews(categories[index].categoryName, 'nl');
                            },
                            child: CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            ),
                          );
                        },
                      ),
                    ),

                    /// Blogs
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              description: articles[index].description,
                              url: articles[index].url,
                              title: articles[index].title);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      appBar: AppBar(
        elevation: 0.0,
        title: GestureDetector(
          onTap: () async {
            Track t = Track(
                name: 'Black & Blue',
                artiest: 'The Rolling Stones',
                style: 1,
                albumSource: 'Zwart & Wit',
                time: '00:3:45');
            String data =
                '{"Name": "Black en Blue","Artist": "Rolling Stones","Style": 1,"AlbumSource": "Black en Blue","Length": "00:04:12"}';
            final response = await http.post(
                Uri.parse('https://soundsharp-api.rocvt-ao.net/api/Artiesten'),
                body: data);
            print(response.body);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flutter",
              ),
              Text(
                "News",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  CategoryTile({this.imageUrl, this.categoryName});
  final imageUrl;
  final categoryName;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: imageUrl,
                width: 120.0,
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ));
  }
}

class BlogTile extends StatelessWidget {
  // Default constructor
  // Dart doesn't support overloaded constructors
  BlogTile(
      {@required this.imageUrl,
      @required this.description,
      @required this.url,
      @required this.title});
  final String imageUrl, description, title, url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
                  return const Text('Image not found');
                },
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
