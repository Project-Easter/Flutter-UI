import 'package:books_app/Models/book.dart';
import 'package:books_app/Screens/book_desciption.dart';
import 'package:books_app/Utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList(this.height, this.bookList, this.headingText);
  final String headingText;
  final double height;
  final List<Book> bookList;

  @override
  Widget build(BuildContext context) {
    if (bookList.isEmpty) {
      return const SizedBox();
    } else {
      return Column(
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
              itemBuilder: (BuildContext context, int index) =>
                  ChangeNotifierProvider<Book>.value(
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
}

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Book book = Provider.of<Book>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => BookDescription(
              bookFromList: book,
            ),
          ),
        );
      },
      child: Container(
        width: getProportionateScreenWidth(127.0),
        margin: const EdgeInsets.only(right: 18.0),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.transparent.withOpacity(0.4),
            title: Text(
              book.title,
              style: const TextStyle(fontSize: 12),
            ),
            subtitle: Text(
              book.author,
              style: const TextStyle(fontSize: 10),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  book.rating.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.white),
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
