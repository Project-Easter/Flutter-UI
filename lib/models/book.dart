import 'package:flutter/cupertino.dart';

class Book with ChangeNotifier {
  final String id;
  final String isbn;
  final String title;
  final String author;
  final String imageUrl;
  double rating;
  final String description;
  final String category;
  bool isBookMarked;
  bool isOwned;
  bool isLent;
  bool isBorrowed;
  final String pages;
  Book({
    this.id,
    this.isbn,
    this.title,
    this.author,
    this.imageUrl,
    this.rating = 0,
    this.isBookMarked = false,
    this.isOwned = false,
    this.isLent = false,
    this.isBorrowed = false,
    this.description,
    this.category,
    this.pages,
  });
  //change isBookMarkedStatus
  void changeBookMark() {
    isBookMarked = !isBookMarked;
    notifyListeners();
  }

  //This Function is to Make Books FROM JSON result
  //Add Book Driver
  // Book makeBook(dynamic result) {
  //   Book book;
  //   if (result != null) {
  //     //Deserialize
  //     String title = result['items'][0]['volumeInfo']['title'];
  //     String author = result['items'][0]['volumeInfo']['authors'][0];
  //     String description = result['items'][0]['volumeInfo']['description'];
  //     String isbn = result['items'][0]['volumeInfo']['industryIdentifiers'][0]
  //         ['identifier'];
  //     String imageLink =
  //         result['items'][0]['volumeInfo']['imageLinks']['thumbnail'];
  //     imageLink = imageLink.replaceFirst("http", "https", 0);
  //     print(imageLink.length);
  //     if (imageLink.isEmpty) {
  //       print("imageLink is empty");
  //     }
  //     print('ISBN' + isbn);
  //     print('Title:' + title);
  //     print('Author:' + author);
  //     print('ImageLink:' + imageLink);
  //     print('Description' + description);
  //     //add ISBN
  //     //Converted to a book object
  //     book = Book(
  //       isbn: isbn,
  //       title: title,
  //       description: description,
  //       imageUrl: imageLink,
  //       author: author,
  //       isOwned: true,
  //     );
  //   }
  //   return book;
  // }
}
//
// class Genre {
//   String name;
//   bool isSelected;
// }
//
//
// List<Genre> genres=[
//   Genre(""),
// ];
