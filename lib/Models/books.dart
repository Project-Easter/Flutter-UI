import 'package:flutter/cupertino.dart';
import 'book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Books with ChangeNotifier {
  //Note:These lists will change and these are dummy data. This is just for filtering demo
  //Owned Books
  List<Book> _ownedBooks = [
    Book(
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        title: 'The History Of Tom Jones, A FoundLing',
        author: 'Henry Fielding',
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BNjU4ZGUyYjUtYzVlMS00YWFmLWFjM2UtYTk5YjFlZmJhNDQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
        rating: 5),
    Book(
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/371px-PrideAndPrejudiceTitlePage.jpg',
        rating: 5),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'The Red and The Black',
      author: 'Stendhai',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/StendhalRedandBlack04.jpg/220px-StendhalRedandBlack04.jpg',
      rating: 4,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Père Goriot',
      author: 'Honoré de Balzac',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/BalzacOldGoriot01.jpg/220px-BalzacOldGoriot01.jpg',
      rating: 3,
    ),
    Book(
      title: 'David Copperfield',
      author: 'Charles Dickens',
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Copperfield_cover_serial.jpg/220px-Copperfield_cover_serial.jpg',
      rating: 5,
    ),
  ];

  //Lent Books
  final List<Book> _lentBooks = [
    Book(
      title: 'Alice in Wonderland',
      author: ' Lewis Carrol',
      imageUrl:
          'https://embed.cdn.pais.scholastic.com/v1/channels/sso/products/identifiers/isbn/9780439291491/primary/renditions/700?useMissingImage=true',
      rating: 3,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Divine Comedy',
      author: 'Dante',
      imageUrl:
          'https://i0.wp.com/theimaginativeconservative.org/wp-content/uploads/2015/07/DivineComedyFresco.jpg?ssl=1',
      rating: 5,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Time Machine',
      author: 'H.G. Wells',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg',
      rating: 4,
    ),
  ];

  //Borrowed Books
  List<Book> _borrowedBooks = [
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Père Goriot',
      author: 'Honoré de Balzac',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/BalzacOldGoriot01.jpg/220px-BalzacOldGoriot01.jpg',
      rating: 3,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Alice in Wonderland',
      author: ' Lewis Carrol',
      imageUrl:
          'https://embed.cdn.pais.scholastic.com/v1/channels/sso/products/identifiers/isbn/9780439291491/primary/renditions/700?useMissingImage=true',
      rating: 3,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Divine Comedy',
      author: 'Dante',
      imageUrl:
          'https://i0.wp.com/theimaginativeconservative.org/wp-content/uploads/2015/07/DivineComedyFresco.jpg?ssl=1',
      rating: 5,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Time Machine',
      author: 'H.G. Wells',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg',
      rating: 4,
    ),
  ];

  //Saved Books

  List<Book> _savedBooks = [
    // Book(
    //     description:
    //         'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    //     title: 'The History Of Tom Jones, A FoundLing',
    //     author: 'Henry Fielding',
    //     imageUrl:
    //         'https://m.media-amazon.com/images/M/MV5BNjU4ZGUyYjUtYzVlMS00YWFmLWFjM2UtYTk5YjFlZmJhNDQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
    //     rating: 4),
    // Book(
    //     description:
    //         'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    //     title: 'Pride and Prejudice',
    //     author: 'Jane Austen',
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/371px-PrideAndPrejudiceTitlePage.jpg',
    //     rating: 5),
  ];

  //Getters for Book List
  List<Book> get ownedBooks {
    return _ownedBooks;
  }

  List<Book> get lentBooks {
    return _lentBooks;
  }

  List<Book> get borrowedBooks {
    return _borrowedBooks;
  }

  //AllBooks-OwnedBooks,Lent,Borrowed Books
  // List<Book> allBooks;
  //
  // List<Book> get allBooksList {
  //   _savedBooks.forEach((book) {
  //     allBooks.add(book);
  //   });
  //   //..add remaining List
  //   return allBooks;
  // }

  List<Book> get savedBooks {
    //***Need to initialize null,as it does not get the reference of _savedBooks
    _savedBooks = [];
    print("Getter SavedBooks called");
    _recommendedBooks.forEach((book) {
      if (book.isBookMarked) {
        _savedBooks.insert(0, book);
        print("${book.title} Book Inserted in SavedBook List");
      }
    });
    _discoverNew.forEach((book) {
      if (book.isBookMarked) {
        _savedBooks.insert(0, book);
        print("${book.title} Book Inserted in SavedBook List");
      }
    });
    return _savedBooks;
  }

  //Filtering Functions
  //A-Z
  void sortAZ() {
    _ownedBooks.sort((a, b) => a.title.compareTo(b.title));
    _lentBooks.sort((a, b) => a.title.compareTo(b.title));
    _borrowedBooks.sort((a, b) => a.title.compareTo(b.title));
    _savedBooks.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  //Z-A
  void sortZA() {
    _ownedBooks.sort((b, a) => a.title.compareTo(b.title));
    _lentBooks.sort((b, a) => a.title.compareTo(b.title));
    _borrowedBooks.sort((b, a) => a.title.compareTo(b.title));
    _savedBooks.sort((b, a) => a.title.compareTo(b.title));
    notifyListeners();
  }

  //Author
  void sortAuthor() {
    _ownedBooks.sort((a, b) => a.author.compareTo(b.author));
    _lentBooks.sort((a, b) => a.author.compareTo(b.author));
    _borrowedBooks.sort((a, b) => a.author.compareTo(b.author));
    _savedBooks.sort((a, b) => a.author.compareTo(b.author));
    notifyListeners();
  }

  //Ratings highest to lowest
  void sortRating() {
    _ownedBooks.sort((b, a) => a.rating.compareTo(b.rating));
    _lentBooks.sort((b, a) => a.rating.compareTo(b.rating));
    _borrowedBooks.sort((b, a) => a.rating.compareTo(b.rating));
    _savedBooks.sort((b, a) => a.rating.compareTo(b.rating));
    notifyListeners();
  }

  //********EXPLORE NEARBY TO BE IMPLEMENTED*******///

  List<Book> _within3km = [
    Book(
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        title: 'The History Of Tom Jones, A FoundLing',
        author: 'Henry Fielding',
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BNjU4ZGUyYjUtYzVlMS00YWFmLWFjM2UtYTk5YjFlZmJhNDQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
        rating: 5),
    Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/371px-PrideAndPrejudiceTitlePage.jpg',
        rating: 5),
    Book(
      title: 'The Red and The Black',
      author: 'Stendhai',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/StendhalRedandBlack04.jpg/220px-StendhalRedandBlack04.jpg',
      rating: 4,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    ),
    Book(
      title: 'Père Goriot',
      author: 'Honoré de Balzac',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/BalzacOldGoriot01.jpg/220px-BalzacOldGoriot01.jpg',
      rating: 3,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    ),
    Book(
      title: 'David Copperfield',
      author: 'Charles Dickens',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Copperfield_cover_serial.jpg/220px-Copperfield_cover_serial.jpg',
      rating: 5,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    ),
  ];

//Lent Books
  List<Book> _within5km = [
    Book(
      title: 'Alice in Wonderland',
      author: ' Lewis Carrol',
      imageUrl:
          'https://embed.cdn.pais.scholastic.com/v1/channels/sso/products/identifiers/isbn/9780439291491/primary/renditions/700?useMissingImage=true',
      rating: 3,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    ),
    Book(
      title: 'Divine Comedy',
      author: 'Dante',
      imageUrl:
          'https://i0.wp.com/theimaginativeconservative.org/wp-content/uploads/2015/07/DivineComedyFresco.jpg?ssl=1',
      rating: 5,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    ),
    Book(
      title: 'Time Machine',
      author: 'H.G. Wells',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg',
      rating: 4,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
    ),
  ];

//Borrowed Books
  List<Book> _within10km = [
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Père Goriot',
      author: 'Honoré de Balzac',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/BalzacOldGoriot01.jpg/220px-BalzacOldGoriot01.jpg',
      rating: 3,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Alice in Wonderland',
      author: ' Lewis Carrol',
      imageUrl:
          'https://embed.cdn.pais.scholastic.com/v1/channels/sso/products/identifiers/isbn/9780439291491/primary/renditions/700?useMissingImage=true',
      rating: 3,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Divine Comedy',
      author: 'Dante',
      imageUrl:
          'https://i0.wp.com/theimaginativeconservative.org/wp-content/uploads/2015/07/DivineComedyFresco.jpg?ssl=1',
      rating: 5,
    ),
    Book(
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'Time Machine',
      author: 'H.G. Wells',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg',
      rating: 4,
    ),
  ];

//Saved Books

  List<Book> _within20km = [
    Book(
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        title: 'The History Of Tom Jones, A FoundLing',
        author: 'Henry Fielding',
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BNjU4ZGUyYjUtYzVlMS00YWFmLWFjM2UtYTk5YjFlZmJhNDQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
        rating: 4),
    Book(
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/371px-PrideAndPrejudiceTitlePage.jpg',
        rating: 5),
  ];

//*******GETTERS
  List<Book> get within3km {
    return [..._within3km];
  }

  List<Book> get within5km {
    return [..._within5km];
  }

  List<Book> get within10km {
    return [..._within10km];
  }

  List<Book> get within20km {
    return [..._within20km];
  }

  //*****RECOMMENDED BOOKS*******//
  List<Book> _recommendedBooks = [
    Book(
      isbn: "2v5oRbptWcoYa0fCVcZA",
      rating: 4,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'The Golem and the Jinni',
      imageUrl:
          'https://images.unsplash.com/photo-1592903189708-add4d2987b1d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=508&q=80',
      author: 'Helence Wecker',
    ),
    Book(
        isbn: "5rdDyYclqWC9Z5xa1A9C",
        rating: 2,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1607948937289-5ca19c59e70f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bm92ZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Economics:The User Guide',
        author: 'Ha-Joon Chang'),
    Book(
        isbn: "6jxYCZOufM3MCsAIGUAs",
        rating: 3,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1573488721809-e0f256ad3ad8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fG5vdmVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Endurance',
        author: 'Alfred Lansing'),
  ];

  List<Book> _discoverNew = [
    Book(
      isbn: "BTmNFEote7etfANyG3aN",
      rating: 5,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'The Golem and the Jinni',
      imageUrl:
          'https://images.unsplash.com/photo-1592903189708-add4d2987b1d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=508&q=80',
      author: 'Helence Wecker',
    ),
    Book(
        isbn: "F5lBUg8F7sT7dNPDEw3f",
        rating: 2,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1607948937289-5ca19c59e70f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bm92ZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Economics:The User Guide',
        author: 'Ha-Joon Chang'),
    Book(
        isbn: "V6z9BLa3Hhx7L8h3jsL8",
        rating: 4,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1573488721809-e0f256ad3ad8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fG5vdmVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Endurance',
        author: 'Alfred Lansing'),
  ];

  List<Book> get recommendedBooks {
    return [..._recommendedBooks];
  }

  List<Book> get discoverNew {
    return [..._discoverNew];
  }

  //***************API CALLS******//

  //TODO:Make a Seperate API Service Class,try using Factory for better parsing.

  //1-Get Book Title By ISBN,2-Get Book ISBN From Name,3-RecommendedBooks From ISBN
  //Get Book By ISBN
  Future<dynamic> getBooksbyISBN(String isbn) async {
    //Add Books from Google API
    String url = "https://www.googleapis.com/books/v1/volumes?q=isbn:";
    try {
      http.Response response = await http.get(url + isbn);
      var result = jsonDecode(response.body);
      print("Result From get Books From ISBN:");
      print(result);
      if (result != null) {
        // //Deserialize
        // String title = result['items'][0]['volumeInfo']['title'];
        // String author = result['items'][0]['volumeInfo']['authors'][0];
        // String description = result['items'][0]['volumeInfo']['description'];
        // String imageLink =
        //     result['items'][0]['volumeInfo']['imageLinks']['thumbnail'];
        // imageLink = imageLink.replaceFirst("http", "https", 0);
        // print(imageLink.length);
        // if (imageLink.isEmpty) {
        //   print("imageLink is empty");
        // }
        // print('Title:' + title);
        // print('Author:' + author);
        // print('ImageLink:' + imageLink);
        // print('Description' + description);

        //Converted to a book object
        // Book book = Book(
        //     title: title,
        //     description: description,
        //     imageUrl: imageLink,
        //     author: author);

        //Use this when using REST
        // ownedBooks.insert(0, book);
        return result;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //1.1 Convert Response to a Book Object

  //Helper-Get Book ISBN From Name
  Future<dynamic> getISBNFromName(String title) async {
    String url = "https://www.googleapis.com/books/v1/volumes?q=";
    try {
      http.Response response = await http.get(url + title);
      var resultJson = jsonDecode(response.body);
      if (resultJson != null) {
        String isbn = resultJson['items'][0]['volumeInfo']
            ['industryIdentifiers'][1]['identifier'];
        return isbn;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  //2.0->Get RecommendedBooks From ISBN
  Future<dynamic> getRecommended(String title) async {
    String recommendedURL =
        "https://explr-books.herokuapp.com/recommend_isbn/?isbn=9781448139859";
    try {
      //Get from recommended
      http.Response response = await http.get(recommendedURL);
      final result = jsonDecode(response.body);
      if (result != null) {
        final booksISBNList = json.decode(response.body);
        final length = booksISBNList.length;
        print(length);
        for (int i = 0; i < length; i++) {
          print("Inside for loop");
          print(booksISBNList[i].toString());
          http.Response responseFromISBN =
              await getBooksbyISBN(booksISBNList[i].toString());
          var data = jsonDecode(responseFromISBN.body);
          print(data);
        }
        return result;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
  //Change this with our REST API Database
  //***************End of class************//
}
