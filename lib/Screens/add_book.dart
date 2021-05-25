import 'package:books_app/Constants/colors.dart';
import 'package:books_app/Models/book.dart';
import 'package:books_app/Models/books.dart';
import 'package:books_app/Services/auth.dart';
import 'package:books_app/Services/database_service.dart';
import 'package:books_app/Widgets/app_bar.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _bookKey = GlobalKey<FormState>();
  final TextEditingController _bookName = TextEditingController();
  final TextEditingController _authorName = TextEditingController();
  final TextEditingController _isbnCode = TextEditingController();

  Widget build(BuildContext context) {
    final dynamic uid = _authService.getUID;
    final DatabaseService _databaseService =
        DatabaseService(uid: uid as String);
    final bookList = Provider.of<Books>(context, listen: false);
    return Scaffold(
      appBar: MyAppBar(context) as PreferredSizeWidget,
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
                      onSaved: (String value) {
                        setState(() {
                          _bookName.text = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
                      onSaved: (String value) {
                        setState(() {
                          _authorName.text = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
                      onSaved: (String value) {
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
                      color: blackButton,
                      myFunction: () async {
                        if (_bookKey.currentState.validate()) {
                          final dynamic result =
                              await bookList.getBooksbyISBN(_isbnCode.text);
                          if (result != null) {
                            final Book book = makeBook(result);
                            await _databaseService.addBook(book);
                            Navigator.pop(context);
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
    );

    // bookDetails() {
    //   return Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Form(
    //       key: _bookKey,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: <Widget>[
    //           Container(
    //             padding: EdgeInsets.symmetric(horizontal: 15),
    //             child: TextFormField(
    //               autocorrect: false,
    //               controller: _bookName,
    //               key: ValueKey('Book Name'),
    //               decoration: InputDecoration(
    //                 hintText: 'Enter Book Name',
    //                 hintStyle: GoogleFonts.poppins(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //               onSaved: (value) {
    //                 setState(() {
    //                   _bookName.text = value;
    //                 });
    //               },
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    //             child: TextFormField(
    //               autocorrect: false,
    //               controller: _authorName,
    //               key: ValueKey('Author Name'),
    //               decoration: InputDecoration(
    //                 hintText: 'Enter Author Name',
    //                 hintStyle: GoogleFonts.poppins(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //               onSaved: (value) {
    //                 setState(() {
    //                   _authorName.text = value;
    //                 });
    //               },
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
    //             child: TextFormField(
    //               controller: _isbnCode,
    //               validator: (value) {
    //                 if (value.isEmpty) {
    //                   return 'Please enter a valid ISBN value';
    //                 }
    //                 if (value.length < 13) {
    //                   return 'Please enter a 13 digit value';
    //                 }
    //                 return null;
    //               },
    //               keyboardType: TextInputType.number,
    //               autocorrect: false,
    //               key: ValueKey('ISBN Code'),
    //               decoration: InputDecoration(
    //                 hintText: 'Enter ISBN Code of the book',
    //                 hintStyle: GoogleFonts.poppins(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //               onSaved: (value) {
    //                 setState(() {
    //                   _isbnCode.text = value;
    //                 });
    //               },
    //               // onChanged: (value) {
    //               //   _isbnCode.text = value;
    //               // },
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(10.0),
    //             // child: button(context, blackButton, 'Add your Book', ''),
    //             child: CupertinoStyleButton(
    //               name: 'Add your Book',
    //               color: blackButton,
    //               myFunction: () {
    //                 if (_bookKey.currentState.validate()) {
    //                   print(_isbnCode.text);
    //                   Navigator.pop(context);
    //                 }
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }

//This Function is to Make Books FROM JSON result
//Add Book Driver
  Book makeBook(dynamic result) {
    Book book;
    if (result != null) {
      //Deserialize
      final String title = result['items'][0]['volumeInfo']['title'] as String;
      final String author =
          result['items'][0]['volumeInfo']['authors'][0] as String;
      final String description =
          result['items'][0]['volumeInfo']['description'] as String;
      final String isbn = result['items'][0]['volumeInfo']
          ['industryIdentifiers'][0]['identifier'] as String;
      String imageLink =
          result['items'][0]['volumeInfo']['imageLinks']['thumbnail'] as String;
      imageLink = imageLink.replaceFirst('http', 'https', 0);
      print(imageLink.length);
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

  //Signup with email and password dummy
  // Future signup() async {
  //   String email = "asdsfffa@asdf.com";
  //   String password = "asdf12345";
  //   var url = 'https://explr-api.herokuapp.com/api/v1/auth/new-account';
  //   var response =
  //       await http.post(url, body: {'email': email, 'password': password});
  //   print('Response status: ${response.statusCode}');
  //   // print(jsonDecode(response.body));
  //   // print('Response body: ${response.body.length}');
  //   //Response iis null.
  //get token
  //   print(response.body);
  // }
}
