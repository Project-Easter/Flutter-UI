import 'package:flutter/material.dart';
import 'package:books_app/util/size_config.dart';
import 'package:books_app/Models/book.dart';

// ignore: must_be_immutable
class HorizontalList extends StatelessWidget {
  double height;
  List<Book> bookList;
  HorizontalList(this.height, this.bookList);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(height),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        semanticChildCount: 2,
        itemBuilder: (context, index) => CustomCard(
          title: bookList[index].title,
          author: bookList[index].author,
          imageUrl: bookList[index].imageUrl,
          rating: bookList[index].rating,
        ),
        itemCount: bookList.length,
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final double rating;
  CustomCard({this.title, this.author, this.imageUrl, this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(127.0),
      margin: EdgeInsets.only(right: 18.0),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.transparent.withOpacity(0.4),
            title: Text(
              title,
              style: TextStyle(fontSize: 12),
            ),
            subtitle: Text(
              author,
              style: TextStyle(fontSize: 10),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  rating.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            )),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
