import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Widgets/appBar.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/books.dart';
import '../Models/book.dart';
import '../Services/auth.dart';
import '../Services/databaseService.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  //
  final AuthService _authService = AuthService();
  final _bookKey = GlobalKey<FormState>();
  final TextEditingController _bookName = TextEditingController();
  final TextEditingController _authorName = TextEditingController();
  final TextEditingController _isbnCode = TextEditingController();

  Widget build(BuildContext context) {
    final uid = _authService.getUID;
    print('Add books');
    //DB
    final DatabaseService _databaseService = DatabaseService(uid: uid);
    final bookList = Provider.of<Books>(context, listen: false);
    return Scaffold(
      appBar: MyAppBar(context),
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
          // bookDetails(),
          Padding(
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
                      controller: _isbnCode,
                      validator: (value) {
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
                          print(_isbnCode.text);
                          //Get book from Google API
                          dynamic result =
                              await bookList.getBooksbyISBN(_isbnCode.text);
                          if (result != null) {
                            //Make Book
                            Book book = makeBook(result);
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

  //Add Book Driver

  Book makeBook(dynamic result) {
    Book book;
    if (result != null) {
      //Deserialize
      String title = result['items'][0]['volumeInfo']['title'];
      String author = result['items'][0]['volumeInfo']['authors'][0];
      String description = result['items'][0]['volumeInfo']['description'];
      String isbn = result['items'][0]['volumeInfo']['industryIdentifiers'][0]
          ['identifier'];
      String imageLink =
          result['items'][0]['volumeInfo']['imageLinks']['thumbnail'];
      imageLink = imageLink.replaceFirst("http", "https", 0);
      print(imageLink.length);
      if (imageLink.isEmpty) {
        print("imageLink is empty");
      }
      print('ISBN' + isbn);
      print('Title:' + title);
      print('Author:' + author);
      print('ImageLink:' + imageLink);
      print('Description' + description);
      //add ISBN
      //Converted to a book object
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
