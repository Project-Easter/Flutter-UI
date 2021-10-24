import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'book.dart';

class Books with ChangeNotifier {

  // Explore Books
  final List<Book> _within3km = <Book>[];
  final List<Book> _within5km = <Book>[];
  final List<Book> _within10km = <Book>[];
  final List<Book> _within20km = <Book>[];
  final List<Book> _morethan20km = <Book>[];

  //Owned Books
  final List<Book> _ownedBooks = <Book>[];

  //Lent Books
  final List<Book> _lentBooks = <Book>[];

  //Borrowed Books
  final List<Book> _borrowedBooks = <Book>[];

  //Saved Books

  List<Book> _savedBooks = <Book>[];

  //Filtering Functions
  //A-Z
  final List<Book> _recommendedBooks = <Book>[];

  //Z-A
  final List<Book> _discoverNew = <Book>[];

  //Author
  List<Book> get borrowedBooks {
    return _borrowedBooks;
  }

  //Ratings highest to lowest
  List<Book> get discoverNew {
    return <Book>[..._discoverNew];
  }

//********EXPLORE NEARBY TO BE IMPLEMENTED*******///
  List<Book> get within3km {
    return _within3km;
  }

  List<Book> get within5km {
    return _within5km;
  }

  List<Book> get within10km {
    return _within10km;
  }

  List<Book> get within20km {
    return _within20km;
  }

  List<Book> get morethan20km {
    return _morethan20km;
  }

  List<Book> get lentBooks {
    return _lentBooks;
  }

//Lent Books
  List<Book> get ownedBooks {
    return _ownedBooks;
  }

//Borrowed Books
  List<Book> get recommendedBooks {
    return <Book>[..._recommendedBooks];
  }

//Saved Books

  List<Book> get savedBooks {
    _savedBooks = <Book>[];
    print('Getter SavedBooks called');
    for (final Book book in _recommendedBooks) {
      if (book.isBookMarked!) {
        _savedBooks.insert(0, book);
        print('${book.title} Book Inserted in SavedBook List');
      }
    }
    for (final Book book in _discoverNew) {
      if (book.isBookMarked!) {
        _savedBooks.insert(0, book);
        print('${book.title} Book Inserted in SavedBook List');
      }
    }
    return _savedBooks;
  }

  Future<dynamic> getBooksbyISBN(String isbn) async {
    //Add Books from Google API
    const String url = 'https://www.googleapis.com/books/v1/volumes?q=isbn:';
    final Map<String, dynamic> res = <String, dynamic>{
      'kind': 'books#volumes',
      'totalItems': 0
    };
    try {
      final http.Response response =
      await http.get(Uri.parse(url + isbn.trim()));
      final dynamic result = jsonDecode(response.body);
      // print("Result From get Books From ISBN:");
      // print(result["items"][0]);
      return result;
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<dynamic> getISBNFromName(String title) async {
    const String url = 'https://www.googleapis.com/books/v1/volumes?q=';
    try {
      final http.Response response = await http.get(Uri.parse(url + title));
      final dynamic resultJson = jsonDecode(response.body);
      if (resultJson != null) {
        final String isbn = resultJson['items'][0]['volumeInfo']
        ['industryIdentifiers'][1]['identifier']
            .toString();
        return isbn;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Book? makeBook(dynamic result) {
    Book? book;

    if (result != null) {
      final String title = result['volumeInfo']['title'].toString();
      final String author = result['volumeInfo']['authors'][0].toString();
      final String description = result['volumeInfo']['description'].toString();
      final String isbn = result['volumeInfo']['industryIdentifiers'][0]
      ['identifier']
          .toString();
      final String infoLink = result['volumeInfo']['infoLink'].toString();

      String imageLink;
      try {
        imageLink = result['volumeInfo']['imageLinks']['thumbnail'].toString();
        imageLink = imageLink.replaceFirst('http', 'https', 0);
      } catch (e) {
        imageLink =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
      }
      print(imageLink.length);
      if (imageLink.isEmpty) {
        print('imageLink is empty');
      }

      book = Book(
        isbn: isbn,
        title: title,
        description: description,
        imageUrl: imageLink,
        author: author,
        infoLink: infoLink,
      );
    }
    notifyListeners();
    return book;
  }

  Book makeBookforDB(dynamic result, String isbnCode, String inputAuthor) {
    // print(result);
    Book book;
    final String? description =
    result['items'][0]['volumeInfo']['description'] as String?;
    final String isbn = isbnCode;
    final String? infoLink =
    result['items'][0]['volumeInfo']['infoLink'] as String?;
    final int? pages = result['items'][0]['volumeInfo']['pageCount'] as int?;
    String? imageLink, title, author;
    try {
      title = result['items'][0]['volumeInfo']['title'] as String?;
      author = result['items'][0]['volumeInfo']['authors'][0] as String?;
      imageLink = result['items'][0]['volumeInfo']['imageLinks']['thumbnail']
      as String?;
      imageLink = imageLink!.replaceFirst('http', 'https', 0);
    } catch (e) {
      imageLink =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
      author = inputAuthor;
      print('imageLink is empty');
    }

    print(FirebaseAuth.instance.currentUser!.uid);
    print('ISBN' + isbn.toString());
    print('Title:' + title.toString());
    print('Author:' + author.toString());
    print('ImageLink:' + imageLink.toString());
    print('Description' + description.toString());
    book = Book(
        isbn: isbn,
        title: title,
        author: author,
        imageUrl: imageLink,
        description: description,
        isOwned: true,
        pages: pages ?? 0,
        infoLink: infoLink);
    return book;
  }

  Future<dynamic> topBooks() async {
    const String recommendedURL =
        'https://www.googleapis.com/books/v1/volumes?q=isbn:';

    try {
      final http.Response response = await http.get(Uri.parse(recommendedURL));
      if (response != null) {
        final dynamic result = jsonDecode(response.body);
        print('result from Google API topBook func is $result');
        final List? list = result['items'] as List?;

        final List<Book?> recommendedBooks = <Book?>[];

        for (dynamic value in list!) {
          recommendedBooks.add(makeBook(value));
        }
        return recommendedBooks;
      }
      return const Text('Result is null');
    } catch (e) {
      print(e.toString());
    }
  }
}