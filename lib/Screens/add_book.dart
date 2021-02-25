import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Widgets/appBar.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _bookKey = GlobalKey<FormState>();
  final TextEditingController _bookName = TextEditingController();
  final TextEditingController _authorName = TextEditingController();
  final TextEditingController _isbnCode = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Add your Book',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 30),
              ),
            ),
            bookDetails(),
          ],
        ));
  }

  bookDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _bookKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                autocorrect: false,
                controller: _bookName,
                key: ValueKey('Book Name'),
                decoration: InputDecoration(
                  hintText: 'Enter Book Name',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
                onSaved: (value) {
                  setState(() {
                    _bookName.text = value;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: TextFormField(
                autocorrect: false,
                controller: _authorName,
                key: ValueKey('Author Name'),
                decoration: InputDecoration(
                  hintText: 'Enter Author Name',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
                onSaved: (value) {
                  setState(() {
                    _authorName.text = value;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: TextFormField(
                autocorrect: false,
                controller: _isbnCode,
                key: ValueKey('ISBN Code'),
                decoration: InputDecoration(
                  hintText: 'Enter ISBN Code of the book',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
                onSaved: (value) {
                  setState(() {
                    _isbnCode.text = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: button(context, blackButton, 'Add your Book', ''),
            ),
          ],
        ),
      ),
    );
  }
}
