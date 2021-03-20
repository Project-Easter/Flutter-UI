import 'package:flutter/material.dart';
import 'package:books_app/util/size_config.dart';
import 'package:books_app/Models/book.dart';
import 'package:provider/provider.dart';
import 'package:books_app/screens/book_desciption.dart';
import 'package:google_fonts/google_fonts.dart';

class HorizontalList extends StatelessWidget {
  final String headingText;
  final double height;
  final List<Book> bookList;
  HorizontalList(this.height, this.bookList, this.headingText);
  @override
  Widget build(BuildContext context) {
    return bookList.length == 0
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: getProportionateScreenHeight(36.0),
                  child: Text(
                    headingText,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                height: getProportionateScreenHeight(height),
                color: Colors.white,
                child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: bookList[index],
                    child: CustomCard(),
                  ),
                  itemCount: bookList.length,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15.0),
              ),
            ],
          );
  }
}

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var book = Provider.of<Book>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookDescription(
              bookFromList: book,
            ),
          ),
        );
      },
      child: Container(
        width: getProportionateScreenWidth(127.0),
        margin: EdgeInsets.only(right: 18.0),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.transparent.withOpacity(0.4),
            title: Text(
              book.title,
              style: TextStyle(fontSize: 12),
            ),
            subtitle: Text(
              book.author,
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
                  book.rating.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          child: Image.network(
            book.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
