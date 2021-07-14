import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'book.dart';

class Books with ChangeNotifier {
  //Note:These lists will change and these are dummy data. This is just for filtering demo
  //Owned Books
  final List<Book> _ownedBooks = <Book>[
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
  final List<Book> _lentBooks = <Book>[
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
  final List<Book> _borrowedBooks = <Book>[
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

  List<Book> _savedBooks = <Book>[
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
  final List<Book> _within3km = <Book>[
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

  final List<Book> _within5km = <Book>[
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

  final List<Book> _within20km = <Book>[
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
  final List<Book> _recommendedBooks = <Book>[
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
  final List<Book> _discoverNew = <Book>[
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
    return <Book>[..._discoverNew];
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
    return <Book>[..._recommendedBooks];
  }

//Saved Books

  List<Book> get savedBooks {
    //***Need to initialize null,as it does not get the reference of _savedBooks
    _savedBooks = <Book>[];
    print('Getter SavedBooks called');
    for (final Book book in _recommendedBooks) {
      if (book.isBookMarked) {
        _savedBooks.insert(0, book);
        print('${book.title} Book Inserted in SavedBook List');
      }
    }
    for (final Book book in _discoverNew) {
      if (book.isBookMarked) {
        _savedBooks.insert(0, book);
        print('${book.title} Book Inserted in SavedBook List');
      }
    }
    return _savedBooks;
  }

//*******GETTERS
  List<Book> get within10km {
    return <Book>[..._within10km];
  }

  List<Book> get within20km {
    return <Book>[..._within20km];
  }

  List<Book> get within3km {
    return <Book>[..._within3km];
  }

  List<Book> get within5km {
    return <Book>[..._within5km];
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

  Future<dynamic> getRecommendedBooks() async {
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
        print(response.body);
        final List<Book> recommendedBooks = <Book>[];
        for (int i = 0; i < length; i++) {
          // print("Inside for loop: ${i}");
          // print(booksISBNList[i].toString());
          final Future<dynamic> responseFromISBN =
              getBooksbyISBN(booksISBNList[i].toString());
          // var data = responseFromISBN;
          // print("Got response back");
          // print(data);
          // final Book book = makeBook(responseFromISBN);
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
      return const Text('Result is null');
    } catch (e) {
      print(e.toString());
    }
  }

  Book makeBook(dynamic result) {
    Book book;
    // final int len = result.length as int;
    if (result != null) {
      //Deserialize

      final String title = result['volumeInfo']['title'].toString();
      final String author = result['volumeInfo']['authors'][0].toString();
      final String description = result['volumeInfo']['description'].toString();
      final String isbn = result['volumeInfo']['industryIdentifiers'][0]
              ['identifier']
          .toString();

      String imageLink;
      try {
        imageLink = result['volumeInfo']['imageLinks']['thumbnail'].toString();
        imageLink = imageLink.replaceFirst('http', 'https', 0);
      } catch (e) {
        imageLink =
            'https://images.unsplash.com/photo-1573488721809-e0f256ad3ad8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fG5vdmVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60';
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
      );

      // print('ISBN' + isbn);
      // print('Title:' + title);
      // print('Author:' + author);
      // print('ImageLink:' + imageLink);
      // print('Description' + description);
      //add ISBN
      //Converted to a book object

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

  void sortAZ() {
    _within3km.sort((Book a, Book b) => a.title.compareTo(b.title));
    _within5km.sort((Book a, Book b) => a.title.compareTo(b.title));
    _within10km.sort((Book a, Book b) => a.title.compareTo(b.title));
    _within20km.sort((Book a, Book b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  void sortRating() {
    _within3km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    _within5km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    _within10km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    _within20km.sort((Book b, Book a) => a.rating.compareTo(b.rating));
    notifyListeners();
  }

  //1.1 Convert Response to a Book Object

  //Helper-Get Book ISBN From Name
  void sortZA() {
    _within3km.sort((Book b, Book a) => a.title.compareTo(b.title));
    _within5km.sort((Book b, Book a) => a.title.compareTo(b.title));
    _within10km.sort((Book b, Book a) => a.title.compareTo(b.title));
    _within20km.sort((Book b, Book a) => a.title.compareTo(b.title));
    notifyListeners();
  }

  Future<dynamic> topBooks() async {
    const String recommendedURL =
        'https://www.googleapis.com/books/v1/volumes?q=isbn';

    try {
      final http.Response response = await http.get(recommendedURL);
      final dynamic result = jsonDecode(response.body);
      print('result is $result');
      final List list = result['items'] as List;
      // list.forEach((dynamic element) {
      //   print(element['volumeInfo']['title']);
      // });

      if (result != null) {
        // final dynamic booksISBNList = jsonDecode(response.body);
        // final int length = list.length as int;
        // print('Length is $length');

        final List<Book> recommendedBooks = <Book>[];
        // for (int i = 0; i < length; i++) {
        //   final Book book = makeBook(booksISBNList);
        //   recommendedBooks.add(book);
        // }
        for (var value in list) {
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
