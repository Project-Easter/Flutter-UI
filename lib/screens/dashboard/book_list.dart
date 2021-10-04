import 'package:books_app/providers/book.dart';
import 'package:books_app/screens/dashboard/bookcard.dart';
import 'package:books_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookList extends StatefulWidget {
  final String title;
  final List<Book> bookList;
  const BookList(this.title, this.bookList);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    print('BookList length is ${widget.bookList.length}');
    SizeConfig().init(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.title,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(350),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.bookList.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChangeNotifierProvider<Book>.value(
                value: widget.bookList[index],
                child: BookCard(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    widget.bookList.shuffle();
    super.initState();
  }
}
