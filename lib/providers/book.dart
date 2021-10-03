import 'package:flutter/cupertino.dart';

class Book with ChangeNotifier {
  final String? id;
  final String? isbn;
  final String? title;
  final String? author;
  final String? imageUrl;
  double? rating;
  final String? description;
  final String? category;
  bool? isBookMarked;
  bool? isOwned;
  bool? isLent;
  bool? isBorrowed;
  final String? pages;
  final String? infoLink;
  // ignore: sort_constructors_first
  Book({
    this.infoLink,
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
    isBookMarked = !isBookMarked!;
    notifyListeners();
  }
}
