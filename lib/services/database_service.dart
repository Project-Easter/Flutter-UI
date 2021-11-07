import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/utils/location_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  final CollectionReference<Map<String, dynamic>> userDataCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> booksCollection =
      FirebaseFirestore.instance.collection('books');

  final CollectionReference<Map<String, dynamic>> chatCollection =
      FirebaseFirestore.instance.collection('chat');

  DatabaseService({this.uid});

  Future<List<UserData>> get allUsers {
    // we can limit the user we are loading at once and do lazyloading
    return userDataCollection.get().then(getAllUserData);
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
            _userDataFromSnapShot(snapshot as DocumentSnapshot<Object>));
    // .map(_userDataFromSnapShot);
  }

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

  List<Book> booksList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((QueryDocumentSnapshot e) => Book(
              title:
                  (e.data()! as Map<String, dynamic>)['title'] as String? ?? '',
              author:
                  (e.data()! as Map<String, dynamic>)['author'] as String? ??
                      '',
              description: (e.data()! as Map<String, dynamic>)['description']
                      as String? ??
                  '',
              genre:
                  (e.data()! as Map<String, dynamic>)['genre'] as String? ?? '',
              imageUrl:
                  (e.data()! as Map<String, dynamic>)['imageUrl'] as String? ??
                      '',
              infoLink:
                  (e.data()! as Map<String, dynamic>)['infoLink'] as String? ??
                      '',
              isbn:
                  (e.data()! as Map<String, dynamic>)['isbn'] as String? ?? '',
              isBookMarked: (e.data()! as Map<String, dynamic>)['isBookMarked']
                      as bool? ??
                  false,
              isBorrowed:
                  (e.data()! as Map<String, dynamic>)['isBorrowed'] as bool? ??
                      false,
              isLent: (e.data()! as Map<String, dynamic>)['isLent'] as bool? ??
                  false,
              isOwned:
                  (e.data()! as Map<String, dynamic>)['isOwned'] as bool? ??
                      false,
              pages: (e.data()! as Map<String, dynamic>)['pages'] as int? ?? 0,
              rating:
                  (e.data()! as Map<String, dynamic>)['rating'] as double? ??
                      0.0,
              userid:
                  (e.data()! as Map<String, dynamic>)['userid'] as String? ??
                      '',
            ))
        .toList();
  }

  ///This is for chat TEST.
  //Get All users Data
  List<UserData> getAllUserData(QuerySnapshot querySnapshot) {
    // ignore: unrelated_type_equality_checks
    return querySnapshot.docs.where((QueryDocumentSnapshot uid) {
      // return this.uid != uid.id;
      return true;
    }).map((QueryDocumentSnapshot doc) {
      return UserData(
        // uid: uid,
        uid: (doc.data()! as Map<String, dynamic>)['uid'] as String?,
        displayName:
            (doc.data()! as Map<String, dynamic>)['displayName'] as String? ??
                'Enter Name',
        email: (doc.data()! as Map<String, dynamic>)['email'] as String? ??
            'example@example.com',
        phoneNumber:
            (doc.data()! as Map<String, dynamic>)['phoneNumber'] as String? ??
                '8844883333',
        streetAddress:
            (doc.data()! as Map<String, dynamic>)['streetAddress'] as String?,
        city: (doc.data()! as Map<String, dynamic>)['city'] as String?,
        photoURL: (doc.data()! as Map<String, dynamic>)['photoURL'] as String?,
        preferences: (doc.data()! as Map<String, dynamic>)['preferences']
            as Map<String, dynamic>?,
        latitude: (doc.data()! as Map<String, dynamic>)['latitude'] as double?,
        longitude:
            (doc.data()! as Map<String, dynamic>)['longitude'] as double?,
      );
    }).toList();
  }

  //Update Users Location
  Future<List<Book>> getBooks({String? uid}) async {
    final List<Book> res = await booksCollection
        .doc(uid)
        .collection('ownedBooks')
        .get()
        .then((QuerySnapshot value) => booksList(value));
    return res;
  }

  Stream<UserData> getUserData(String? userid) {
    return userDataCollection.doc(userid).snapshots().map(
        (DocumentSnapshot<dynamic> snapshot) =>
            _userDataFromSnapShot(snapshot as DocumentSnapshot<Object>));
    // .map(_userDataFromSnapShot);
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

  void removeBook(String? isbn) {
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
        .update(<String, bool?>{
      'isBookMarked': book.isBookMarked,
    });

    await booksCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(book.isbn)
        .update(<String, bool?>{
      'isBookMarked': book.isBookMarked,
    });
  }

  Future<void> updateGenres(List<String> genres) async {
    return userDataCollection.doc(uid).set(<String, dynamic>{
      'preferences': <String, dynamic>{'genres': genres}
    }, SetOptions(merge: true));
  }

  Future<void> updatePreferences(String favAuthor, String favBook) async {
    return userDataCollection.doc(uid).set(<String, dynamic>{
      'preferences': <String, dynamic>{
        'favAuthor': favAuthor,
        'favBook': favBook,
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
  Future<void> updateUser(
      String name, String city, String streetAddress, String photoURL) async {
    return userDataCollection.doc(uid).set(<String, String>{
      'city': city,
      'streetAddress': streetAddress,
      'displayName': name,
      'photoURL': photoURL,
    }, SetOptions(merge: true));
  }

  //2.0->Update BookMark toggle bookmark
  Future<void> updateUserData(UserData userData) async {
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
        'streetAddress': userData.streetAddress,
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

  Future<void> updateUserLocation(double latitude, double longitude) async {
    final List<String?> addresses =
        await LocationHelper().getAddressFromLatLng(latitude, longitude);

    return userDataCollection.doc(uid).set(<String, dynamic>{
      'streetAddress': addresses[0],
      'city': addresses[1],
      'country': addresses[2],
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }

  List<Book> _bookFromQuerySnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((QueryDocumentSnapshot doc) {
      return Book(
          // rating: doc.data()['rating'] as double,
          isOwned: (doc.data()! as Map<String, dynamic>)['isOwned'] as bool?,
          userid: (doc.data()! as Map<String, dynamic>)['userid'] as String?,
          isBookMarked:
              (doc.data()! as Map<String, dynamic>)['isBookMarked'] as bool?,
          imageUrl:
              (doc.data()! as Map<String, dynamic>)['imageUrl'] as String?,
          title: (doc.data()! as Map<String, dynamic>)['title'] as String?,
          isbn: (doc.data()! as Map<String, dynamic>)['isbn'] as String?,
          author: (doc.data()! as Map<String, dynamic>)['author'] as String?,
          description:
              (doc.data()! as Map<String, dynamic>)['description'] as String?);
    }).toList();
  }

  UserData _userDataFromSnapShot(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: uid,
      displayName: (documentSnapshot.data()!
              as Map<String, dynamic>)['displayName'] as String? ??
          'Enter Name',
      email: (documentSnapshot.data()! as Map<String, dynamic>)['email']
              as String? ??
          'example@example.com',
      phoneNumber: (documentSnapshot.data()!
              as Map<String, dynamic>)['phoneNumber'] as String? ??
          '8844883333',
      streetAddress: (documentSnapshot.data()!
          as Map<String, dynamic>)['streetAddress'] as String?,
      city:
          (documentSnapshot.data()! as Map<String, dynamic>)['city'] as String?,
      photoURL: (documentSnapshot.data()! as Map<String, dynamic>)['photoURL']
          as String?,
      preferences: (documentSnapshot.data()!
          as Map<String, dynamic>)['preferences'] as Map<String, dynamic>?,
      latitude: (documentSnapshot.data()! as Map<String, dynamic>)['latitude']
          as double?,
      longitude: (documentSnapshot.data()! as Map<String, dynamic>)['longitude']
          as double?,
    );
  }
//**End of DB service
}
