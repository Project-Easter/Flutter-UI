import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/utils/location_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');

  DatabaseService({this.uid});

  Stream<List<UserData>> get allUsers {
    return userDataCollection.snapshots().map(getAllUserData);
  }

  Stream<List<Book>> get booksData {
    return userDataCollection
        .doc(uid)
        .collection('ownedBooks')
        .snapshots()
        .map(_bookFromQuerySnapShot);
  }

  //get user data from stream with uid
  Stream<UserData> get userData {
    return userDataCollection.doc(uid).snapshots().map(
        (DocumentSnapshot<dynamic> snapshot) =>
            _userDataFromSnapShot(snapshot));
    // .map(_userDataFromSnapShot);
  }

  //Update Users Location
  Future<void> addBook(Book book) async {
    //GET BOOK FROM API or an existing List and adds to both users and books collection
    await userDataCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(book.isbn)
        .set(<String, dynamic>{
      'rating': book.rating,
      'isbn': book.isbn,
      'isBookMarked': book.isBookMarked,
      'isOwned': book.isOwned ?? false,
      'isLent': book.isLent,
      'isBorrowed': book.isBorrowed,
      'title': book.title,
      'description': book.description,
      'imageUrl': book.imageUrl,
      'author': book.author,
      'pages': book.pages,
      'infoLink': book.infoLink,
      'genre': book.genre,
      'userid': uid
    });
    await booksCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(book.isbn)
        .set(<String, dynamic>{
      'rating': book.rating,
      'isbn': book.isbn,
      'isBookMarked': book.isBookMarked,
      'isOwned': book.isOwned ?? false,
      'isLent': book.isLent,
      'isBorrowed': book.isBorrowed,
      'title': book.title,
      'description': book.description,
      'imageUrl': book.imageUrl,
      'author': book.author,
      'pages': book.pages,
      'infoLink': book.infoLink,
      'genre': book.genre,
      'userid': uid
    });
  }

  ///This is for chat TEST.
  //Get All users Data
  List<UserData> getAllUserData(QuerySnapshot querySnapshot) {
    // ignore: unrelated_type_equality_checks
    return querySnapshot.docs.where((QueryDocumentSnapshot uid) {
      return uid != uid;
    }).map((QueryDocumentSnapshot doc) {
      return UserData(
        // uid: uid,
        uid: (doc.data() as Map)['uid'] as String,
        displayName:
            (doc.data() as Map)['displayName'] as String ?? 'Enter Name',
        email: (doc.data() as Map)['email'] as String ?? 'example@example.com',
        phoneNumber:
            (doc.data() as Map)['phoneNumber'] as String ?? '8844883333',
        state: (doc.data() as Map)['state'] as String,
        city: (doc.data() as Map)['city'] as String,
        photoURL: (doc.data() as Map)['photoURL'] as String,
        preferences: (doc.data() as Map)['preferences'] as Map<String, dynamic>,
        latitude: (doc.data() as Map)['latitude'] as double,
        longitude: (doc.data() as Map)['longitude'] as double,
      );
    }).toList();
  }

  // Stream<QuerySnapshot> getMessageStream(String from, String to) {
  //   return chatCollection
  //       .doc(from)
  //       .collection('conversation')
  //       .doc(to)
  //       .collection('messages')
  //       .orderBy('createdAt', descending: false) //
  //       .snapshots();
  //   // .map(_messageFromSnapshot);
  // }

  void removeBook(String isbn) {
    print(isbn);
    booksCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(isbn)
        .delete()
        .catchError((dynamic e) => print(e.toString()));
    userDataCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(isbn)
        .delete()
        .catchError((dynamic e) => print(e.toString()));
  }

  // Future<DocumentReference> sendMessage(Message message) async {
  //   // final newMessage = Message(
  //   //   from: myUID,
  //   //   to: receiverUID,
  //   //   message: message,
  //   //   createdAt: DateTime.now(),
  //   // );

  //   //Sender sends a message
  //   return chatCollection
  //       .doc(message.sender)
  //       .collection('conversation')
  //       .doc(message.receiver)
  //       .collection('messages')
  //       .add(<String, dynamic>{
  //     'sender': message.sender,
  //     'receiver': message.receiver,
  //     'message': message.message,
  //     'createdAt': message.createdAt
  //   });
  //   // Message(
  //   //   sender: doc.data()['sender'],
  //   //   receiver: doc.data()['receiver'],
  //   //   message: doc.data()['message'],
  //   //   createdAt: doc.data()['createdAt'],
  //   // );
  //   //update receiver inbox
  // }
  Future<void> updateBookMark(Book book) async {
    //Get
    print('Check bookmark');

    // final DocumentReference docReference =
    //     booksCollection.doc(uid).collection('ownedBooks').doc(book.isbn);
    await userDataCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(book.isbn)
        .update(<String, bool>{
      'isBookMarked': book.isBookMarked,
    });

    await booksCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(book.isbn)
        .update(<String, bool>{
      'isBookMarked': book.isBookMarked,
    });
  }

  Future<void> updateGenres(List<String> genres) async {
    return userDataCollection.doc(uid).set(<String, dynamic>{
      'preferences': <String, dynamic>{'genres': genres}
    }, SetOptions(merge: true));
  }

  Future updatePreferences(
      String favAuthor, String favBook, String locationRange) async {
    return userDataCollection.doc(uid).set(<String, dynamic>{
      'preferences': {
        'favAuthor': favAuthor,
        'favBook': favBook,
        'locationRange': locationRange
      }
    }, SetOptions(merge: true));
  }

  //get Book data from stream with uid
  // Stream<List<Book>> get booksData {
  //   return booksCollection.snapshots().map((_bookFromQuerySnapShot));
  // }

  //Read from firestore
  void updateRating(double star, String isbn) {
    booksCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(isbn)
        .set(<String, dynamic>{
      'rating': star,
    }, SetOptions(merge: true)).then((_) => print('Done'));
  }

  //*********Updates***************//
  //1.0->Update Rating a book by giving Star
  Future updateUser(
      String name, String city, String state, String photoURL) async {
    return userDataCollection.doc(uid).set(<String, dynamic>{
      'city': city,
      'state': state,
      'displayName': name,
      'photoURL': photoURL,
    }, SetOptions(merge: true));
  }

  //2.0->Update BookMark toggle bookmark
  Future updateUserData(UserData userData) async {
    return userDataCollection.doc(uid).set(
      <String, dynamic>
      // ignore: always_specify_types
      {
        'uid': uid,
        // 'token':
        'displayName': userData.displayName,
        'email': userData.email,
        'emailVerified': userData.emailVerified,
        'isAnonymous': userData.isAnonymous,
        'phoneNumber': userData.phoneNumber,
        'photoURL': userData.photoURL,
        'city': userData.city,
        'state': userData.state,
        'country': userData.countryName,
        // ignore: always_specify_types
        'preferences': {
          'favAuthor': '',
          'favBook': '',
          'locationRange': '10',
        },
        'latitude': userData.latitude,
        'longitude': userData.longitude,
      },
    );
  }

  Future updateUserLocation(double latitude, double longitude) async {
    final List<String> addresses =
        await LocationHelper().getAddressFromLatLng(latitude, longitude);

    return userDataCollection.doc(uid).set(<String, dynamic>{
      'city': addresses[0],
      'state': addresses[1],
      'country': addresses[2],
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }

  List<Book> _bookFromQuerySnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((QueryDocumentSnapshot doc) {
      // print(doc.data);
      return Book(
          // rating: doc.data()['rating'] as double,
          isOwned: (doc.data() as Map)['isOwned'] as bool,
          isBookMarked: (doc.data() as Map)['isBookMarked'] as bool,
          imageUrl: (doc.data() as Map)['imageUrl'] as String,
          title: (doc.data() as Map)['title'] as String,
          isbn: (doc.data() as Map)['isbn'] as String,
          author: (doc.data() as Map)['author'] as String,
          description: (doc.data() as Map)['description'] as String);
    }).toList();
  }

  UserData _userDataFromSnapShot(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: uid,
      displayName: (documentSnapshot.data() as Map)['displayName'] as String ??
          'Enter Name',
      email: (documentSnapshot.data() as Map)['email'] as String ??
          'example@example.com',
      phoneNumber: (documentSnapshot.data() as Map)['phoneNumber'] as String ??
          '8844883333',
      state: (documentSnapshot.data() as Map)['state'] as String,
      city: (documentSnapshot.data() as Map)['city'] as String,
      photoURL: (documentSnapshot.data() as Map)['photoURL'] as String,
      preferences: (documentSnapshot.data() as Map)['preferences']
          as Map<String, dynamic>,
      latitude: (documentSnapshot.data() as Map)['latitude'] as double,
      longitude: (documentSnapshot.data() as Map)['longitude'] as double,
    );
  }

  //**End of DB service
}
