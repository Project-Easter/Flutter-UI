import 'package:books_app/constants/colors.dart';
import 'package:books_app/widgets/app_bar.dart';
import 'package:books_app/widgets/button.dart';
import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key key}) : super(key: key);
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  // final FirebaseAuthService _authService =
  //     FirebaseAuthService();
  final GlobalKey<FormState> _bookKey = GlobalKey<FormState>();
  final TextEditingController _bookName = TextEditingController();
  final TextEditingController _authorName = TextEditingController();
  final TextEditingController _isbnCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final dynamic uid = _authService.getUID;
    // final DatabaseService _databaseService =
    //     DatabaseService(uid: uid as String);
    final Books bookList = Provider.of<Books>(context, listen: false);
    return Scaffold(
      appBar: MyAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Add your Book',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _bookKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        autocorrect: false,
                        controller: _bookName,
                        key: const ValueKey<String>('Book Name'),
                        decoration: InputDecoration(
                          hintText: 'Enter Book Name',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          setState(() {
                            _bookName.text = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: TextFormField(
                        autocorrect: false,
                        controller: _authorName,
                        key: const ValueKey<String>('Author Name'),
                        decoration: InputDecoration(
                          hintText: 'Enter Author Name',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          setState(() {
                            _authorName.text = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: TextFormField(
                        controller: _isbnCode,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid ISBN value';
                          }
                          if (value.length < 10 || value.length > 13) {
                            return 'Please enter a 10 or 13 digit value';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        key: const ValueKey<String>('ISBN Code'),
                        decoration: InputDecoration(
                          hintText: 'Enter ISBN Code of the book',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          setState(() {
                            _isbnCode.text = value;
                          });
                        },
                        // onChanged: (value) {
                        //   _isbnCode.text = value;
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      // child: button(context, blackButton, 'Add your Book', ''),
                      child: CupertinoStyleButton(
                        name: 'Add your Book',
                        color: Colors.blueAccent,
                        myFunction: () async {
                          if (_bookKey.currentState.validate()) {
                            _bookKey.currentState.save();
                            final dynamic result =
                                await bookList.getBooksbyISBN(_isbnCode.text);
                            if (result != null) {
                              final Book book = makeBook(result);
                              bookList.postAddedBook(book);
                              // await _databaseService.addBook(book);

                              final SnackBar snackbar = SnackBar(
                                content: const Text('Your book has been added'),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//This Function is to Make Books FROM JSON result
//Add Book Driver
  Book makeBook(dynamic result) {
    Book book;
    if (result != null) {
      final String title = result['title'] as String;
      final String author = result['author'] as String;
      final String description = result['description'] as String;
      final String isbn = result['isbn'] as String;
      String imageLink = result['image'] as String;
      imageLink = imageLink.replaceFirst('http', 'https', 0);

      if (imageLink.isEmpty) {
        print('imageLink is empty');
      }
      print('ISBN' + isbn);
      print('Title:' + title);
      print('Author:' + author);
      print('ImageLink:' + imageLink);
      print('Description' + description);
      book = Book(
        isbn: isbn,
        title: title,
        description: description,
        imageUrl: imageLink,
        author: author,
        isOwned: true,
      );
    }
    return book;
  }
}
