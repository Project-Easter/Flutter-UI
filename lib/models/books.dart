import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'book.dart';

class Books with ChangeNotifier {
  //Note:These lists will change and these are dummy data. This is just for filtering demo
  //Owned Books
  final List<Book> _ownedBooks = [
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
  final List<Book> _borrowedBooks = [
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
  final List<Book> _within3km = [
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

  final List<Book> _within5km = [
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

  final List<Book> _within10km = <Book>[
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

  final List<Book> _within20km = [
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

  //Filtering Functions
  //A-Z
  final List<Book> _recommendedBooks = [
    Book(
      isbn: '2v5oRbptWcoYa0fCVcZA',
      rating: 4,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'The Golem and the Jinni',
      imageUrl:
          'https://images.unsplash.com/photo-1592903189708-add4d2987b1d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=508&q=80',
      author: 'Helence Wecker',
    ),
    Book(
        isbn: '5rdDyYclqWC9Z5xa1A9C',
        rating: 2,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1607948937289-5ca19c59e70f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bm92ZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Economics:The User Guide',
        author: 'Ha-Joon Chang'),
    Book(
        isbn: '6jxYCZOufM3MCsAIGUAs',
        rating: 3,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1573488721809-e0f256ad3ad8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fG5vdmVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Endurance',
        author: 'Alfred Lansing'),
  ];

  //Z-A
  final List<Book> _discoverNew = [
    Book(
      isbn: 'BTmNFEote7etfANyG3aN',
      rating: 5,
      description:
          'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
      title: 'The Golem and the Jinni',
      imageUrl:
          'https://images.unsplash.com/photo-1592903189708-add4d2987b1d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=508&q=80',
      author: 'Helence Wecker',
    ),
    Book(
        isbn: 'F5lBUg8F7sT7dNPDEw3f',
        rating: 2,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1607948937289-5ca19c59e70f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bm92ZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Economics:The User Guide',
        author: 'Ha-Joon Chang'),
    Book(
        isbn: 'V6z9BLa3Hhx7L8h3jsL8',
        rating: 4,
        description:
            'Labore sunt veniam amet est. Minim nisi dolor eu ad incididunt cillum elit ex ut. Dolore exercitation nulla tempor consequat aliquip occaecat. Nisi id ipsum irure aute. Deserunt sit aute irure quis nulla eu consequat fugiat Lorem sunt magna et consequat labore. Laboris incididunt id Lorem est duis deserunt nisi dolore eiusmod culpa.',
        imageUrl:
            'https://images.unsplash.com/photo-1573488721809-e0f256ad3ad8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fG5vdmVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        title: 'Endurance',
        author: 'Alfred Lansing'),
  ];

  //Author
  List<Book> get borrowedBooks {
    return _borrowedBooks;
  }

  //Ratings highest to lowest
  List<Book> get discoverNew {
    return [..._discoverNew];
  }

  //********EXPLORE NEARBY TO BE IMPLEMENTED*******///

  List<Book> get lentBooks {
    return _lentBooks;
  }

//Lent Books
  List<Book> get ownedBooks {
    return _ownedBooks;
  }

//Borrowed Books
  List<Book> get recommendedBooks {
    return [..._recommendedBooks];
  }

//Saved Books

  List<Book> get savedBooks {
    //***Need to initialize null,as it does not get the reference of _savedBooks
    _savedBooks = [];
    print('Getter SavedBooks called');
    _recommendedBooks.forEach((book) {
      if (book.isBookMarked) {
        _savedBooks.insert(0, book);
        print('${book.title} Book Inserted in SavedBook List');
      }
    });
    _discoverNew.forEach((book) {
      if (book.isBookMarked) {
        _savedBooks.insert(0, book);
        print('${book.title} Book Inserted in SavedBook List');
      }
    });
    return _savedBooks;
  }

//*******GETTERS
  List<Book> get within10km {
    return [..._within10km];
  }

  List<Book> get within20km {
    return [..._within20km];
  }

  List<Book> get within3km {
    return [..._within3km];
  }

  List<Book> get within5km {
    return [..._within5km];
  }

  //*****RECOMMENDED BOOKS*******//
  Future<dynamic> getBooksbyISBN(String isbn) async {
    //Add Books from Google API
    const String url = 'https://www.googleapis.com/books/v1/volumes?q=isbn';
    try {
      final http.Response response = await http.get(url + isbn);
      final dynamic result = jsonDecode(response.body);
      // print("Result From get Books From ISBN:");

      // print(result);
      if (result != null) {
        return result;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<dynamic> getISBNFromName(String title) async {
    const String url = 'https://www.googleapis.com/books/v1/volumes?q=';
    try {
      final http.Response response = await http.get(url + title);
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

  Future<dynamic> getRecommendedBooks(String title) async {
    //For now we are not using title
    const String recommendedURL =
        'https://explr-books.herokuapp.com/recommend_isbn/?isbn=9781448139859';
    try {
      //Get from recommended
      final http.Response response = await http.get(recommendedURL);
      final dynamic result = jsonDecode(response.body);
      if (result != null) {
        final dynamic booksISBNList = json.decode(response.body);
        final int length = booksISBNList.length as int;
        // print(length);
        final List<Book> recommendedBooks = [];
        for (int i = 0; i < length; i++) {
          // print("Inside for loop: ${i}");
          // print(booksISBNList[i].toString());
          final Future<dynamic> responseFromISBN =
              getBooksbyISBN(booksISBNList[i].toString());
          // var data = responseFromISBN;
          // print("Got response back");
          // print(data);
          final Book book = makeBook(responseFromISBN);
          recommendedBooks.add(book);
          // if (data != null) {
          //   Map<String, dynamic> json = data;
          //   print(json);
          // }
          // print(data);
        }
        return recommendedBooks;
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Book makeBook(dynamic result) {
    Book book;
    if (result != null) {
      //Deserialize
      final String title = result['items'][0]['volumeInfo']['title'].toString();
      final String author =
          result['items'][0]['volumeInfo']['authors'][0].toString();
      final String description =
          result['items'][0]['volumeInfo']['description'].toString();
      final String isbn = result['items'][0]['volumeInfo']
              ['industryIdentifiers'][0]['identifier']
          .toString();
      String imageLink = result['items'][0]['volumeInfo']['imageLinks']
              ['thumbnail']
          .toString();
      imageLink = imageLink.replaceFirst('http', 'https', 0);
      print(imageLink.length);
      if (imageLink.isEmpty) {
        print('imageLink is empty');
      }
      // print('ISBN' + isbn);
      // print('Title:' + title);
      // print('Author:' + author);
      // print('ImageLink:' + imageLink);
      // print('Description' + description);
      //add ISBN
      //Converted to a book object
      book = Book(
        isbn: isbn,
        title: title,
        description: description,
        imageUrl: imageLink,
        author: author,
      );
    }
    return book;
  }

  void sortAuthor() {
    _within3km.sort((Book a, Book b) => a.author.compareTo(b.author));
    _within5km.sort((Book a, Book b) => a.author.compareTo(b.author));
    _within10km.sort((Book a, Book b) => a.author.compareTo(b.author));
    _within20km.sort((Book a, Book b) => a.author.compareTo(b.author));
    notifyListeners();
  }

  //1.1 Convert Response to a Book Object

  //Helper-Get Book ISBN From Name
  void sortAZ() {
    _within3km.sort((a, b) => a.title.compareTo(b.title));
    _within5km.sort((a, b) => a.title.compareTo(b.title));
    _within10km.sort((a, b) => a.title.compareTo(b.title));
    _within20km.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  //2.0->Get RecommendedBooks From ISBN
  void sortRating() {
    _within3km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    _within5km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    _within10km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    _within20km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    notifyListeners();
  }

//This Function is to Make Books FROM JSON result
//Add Book Driver
  void sortZA() {
    _within3km.sort((b, a) => a.title.compareTo(b.title));
    _within5km.sort((b, a) => a.title.compareTo(b.title));
    _within10km.sort((b, a) => a.title.compareTo(b.title));
    _within20km.sort((b, a) => a.title.compareTo(b.title));
    notifyListeners();
  }

  //Change this with our REST API Database
  //***************End of class************//
}
