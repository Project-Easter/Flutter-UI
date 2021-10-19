import 'package:flutter/cupertino.dart';

class Book with ChangeNotifier {
  // final String id;
  final String? isbn;
  final String? title;
  final String? author;
  final String? imageUrl;
  final String? userid;
  double rating;
  final String? description;
  final String? genre;
  bool? isBookMarked;
  bool? isOwned;
  bool isLent;
  bool isBorrowed;
  final int pages;
  final String? infoLink;

  Book({
    // this.id,
    this.isbn,
    this.title='',
    this.author,
    this.imageUrl = '',
    this.userid,
    this.description,
    this.genre,
    this.rating = 0,
    this.isBookMarked = false,
    this.isOwned = false,
    this.isLent = false,
    this.isBorrowed = false,
    // this.category,
    this.pages = 0,
    this.infoLink,
  });
  //change isBookMarkedStatus
  void changeBookMark() {
    isBookMarked = !isBookMarked!;
    notifyListeners();
  }
}
