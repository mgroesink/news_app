import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CategoryTile(),
      ),
      appBar: AppBar(
          elevation: 0.0,
          title: Row(
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
          )),
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
        child: Stack(
      children: <Widget>[
        Image.network(
          imageUrl,
          width: 120.0,
          height: 60.0,
        )
      ],
    ));
  }
}
