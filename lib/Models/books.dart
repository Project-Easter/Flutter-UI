import 'package:flutter/cupertino.dart';
import 'book.dart';

class Books with ChangeNotifier {
  //Note:These lists will change and these are dummy data. This is just for filtering demo

  //Owned Books
  List<Book> _ownedBooks = [
    Book(
        title: 'The History Of Tom Jones, A FoundLing',
        author: 'Henry Fielding',
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BNjU4ZGUyYjUtYzVlMS00YWFmLWFjM2UtYTk5YjFlZmJhNDQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
        rating: 5),
    Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/371px-PrideAndPrejudiceTitlePage.jpg',
        rating: 5),
    Book(
      title: 'The Red and The Black',
      author: 'Stendhai',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/StendhalRedandBlack04.jpg/220px-StendhalRedandBlack04.jpg',
      rating: 4,
    ),
    Book(
      title: 'Père Goriot',
      author: 'Honoré de Balzac',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/BalzacOldGoriot01.jpg/220px-BalzacOldGoriot01.jpg',
      rating: 3,
    ),
    Book(
      title: 'David Copperfield',
      author: 'Charles Dickens',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Copperfield_cover_serial.jpg/220px-Copperfield_cover_serial.jpg',
      rating: 5,
    ),
  ];

  //Lent Books
  List<Book> _lentBooks = [
    Book(
      title: 'Alice in Wonderland',
      author: ' Lewis Carrol',
      imageUrl:
          'https://embed.cdn.pais.scholastic.com/v1/channels/sso/products/identifiers/isbn/9780439291491/primary/renditions/700?useMissingImage=true',
      rating: 3,
    ),
    Book(
      title: 'Divine Comedy',
      author: 'Dante',
      imageUrl:
          'https://i0.wp.com/theimaginativeconservative.org/wp-content/uploads/2015/07/DivineComedyFresco.jpg?ssl=1',
      rating: 5,
    ),
    Book(
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
      title: 'Père Goriot',
      author: 'Honoré de Balzac',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/BalzacOldGoriot01.jpg/220px-BalzacOldGoriot01.jpg',
      rating: 3,
    ),
    Book(
      title: 'Alice in Wonderland',
      author: ' Lewis Carrol',
      imageUrl:
          'https://embed.cdn.pais.scholastic.com/v1/channels/sso/products/identifiers/isbn/9780439291491/primary/renditions/700?useMissingImage=true',
      rating: 3,
    ),
    Book(
      title: 'Divine Comedy',
      author: 'Dante',
      imageUrl:
          'https://i0.wp.com/theimaginativeconservative.org/wp-content/uploads/2015/07/DivineComedyFresco.jpg?ssl=1',
      rating: 5,
    ),
    Book(
      title: 'Time Machine',
      author: 'H.G. Wells',
      imageUrl:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1327942880l/2493.jpg',
      rating: 4,
    ),
  ];

  //Saved Books

  List<Book> _savedBooks = [
    Book(
        title: 'The History Of Tom Jones, A FoundLing',
        author: 'Henry Fielding',
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BNjU4ZGUyYjUtYzVlMS00YWFmLWFjM2UtYTk5YjFlZmJhNDQyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
        rating: 4),
    Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/PrideAndPrejudiceTitlePage.jpg/371px-PrideAndPrejudiceTitlePage.jpg',
        rating: 5),
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

  List<Book> get savedBooks {
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
}

// buildFilterItems('Sort title A-Z', () {}),
// buildFilterItems('Sort title Z-A', () {}),
// buildFilterItems('Sort by author', () {}),
// buildFilterItems('Sort by rating', () {}),
