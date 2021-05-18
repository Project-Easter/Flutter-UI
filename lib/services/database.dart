import 'package:books_app/screens/user_preferences.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:books_app/models/message.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userDataCollection = FirebaseFirestore.instance.collection('users');

  final CollectionReference booksCollection = FirebaseFirestore.instance.collection('books');

  final CollectionReference chatCollection = FirebaseFirestore.instance.collection('chat');

  Future updateUserData(UserData userData) async {
    return await userDataCollection.doc(uid).set(
      {
        "uid": uid,
        "displayName": userData.displayName,
        "email": userData.email,
        "emailVerified": userData.emailVerified,
        "isAnonymous": userData.isAnonymous,
        "phoneNumber": userData.phoneNumber,
        "photoURL": userData.photoURL,
        "city": userData.city,
        "state": userData.state,
        "preferences": {
          "favAuthor": "",
          "favBook": "",
          "locationRange": "10",
        },
        "latitude": userData.latitude,
        "longitude": userData.longitude,
      },
    );
  }

  UserData _userDataFromSnapShot(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: uid,
      displayName: documentSnapshot.data()['displayName'] ?? "Enter Name",
      email: documentSnapshot.data()['email'] ?? "example@example.com",
      phoneNumber: documentSnapshot.data()['phoneNumber'] ?? "8844883333",
      state: documentSnapshot.data()['state'],
      city: documentSnapshot.data()['city'],
      photoURL: documentSnapshot.data()['photoURL'],
      preferences: documentSnapshot.data()['preferences'],
      latitude: documentSnapshot.data()['latitude'],
      longitude: documentSnapshot.data()['longitude'],
    );
  }

  //get user data from stream with uid
  Stream<UserData> get userData {
    return userDataCollection
        .doc(uid)
        .snapshots()
        // .map((snapshot) => _userDataFromSnapShot(snapshot));
        .map(_userDataFromSnapShot);
  }

  //Update Users Location
  Future updateUserLocation(double latitude, double longititude) async {
    return await userDataCollection.doc(uid).set({
      "latitude": latitude,
      "longitude": longititude,
    }, SetOptions(merge: true));
  }

  Future updateUser(String name, String city, String state, String photoURL) async {
    return await userDataCollection.doc(uid).set({
      "city": city,
      "state": state,
      "displayName": name,
      "photoURL": photoURL,
    }, SetOptions(merge: true));
  }

  Future updateGenres(List<String> genres) async {
    return await userDataCollection.doc(uid).set({
      "preferences": {"genres": genres}
    }, SetOptions(merge: true));
  }

  Future updatePreferences(String favAuthor, String favBook, String locationRange) async {
    return await userDataCollection.doc(uid).set({
      "preferences": {"favAuthor": favAuthor, "favBook": favBook, "locationRange": locationRange}
    }, SetOptions(merge: true));
  }

  ///This is for chat TEST.
  //Get All users Data
  List<UserData> getAllUserData(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.where((uid) => uid != uID).map((doc) {
      return UserData(
        // uid: uid,
        uid: doc.data()['uid'],
        displayName: doc.data()['displayName'] ?? "Enter Name",
        email: doc.data()['email'] ?? "example@example.com",
        phoneNumber: doc.data()['phoneNumber'] ?? "8844883333",
        state: doc.data()['state'],
        city: doc.data()['city'],
        photoURL: doc.data()['photoURL'],
        preferences: doc.data()['preferences'],
        latitude: doc.data()['latitude'],
        longitude: doc.data()['longitude'],
      );
    }).toList();
  }

  Stream<List<UserData>> get allUsers {
    return userDataCollection.snapshots().map(getAllUserData);
  }
  // Stream<QuerySnapshot> get allUsers {
  //   return userDataCollection.snapshots();
  // }
  //**********************//*********Books***********//******************************//

  //Add Book to collection
  // Sample 10 digit ISBN to ADD
  //8176561061
  //0764526413
  //0136091814

  Future addBook(Book book) async {
    //GET BOOK FROM API or an existing List
    return await booksCollection.doc(uid).collection('ownedBooks').doc(book.isbn).set({
      "rating": book.rating,
      "isbn": book.isbn,
      "isBookMarked": book.isBookMarked,
      "isOwned": book.isOwned ?? false,
      "title": book.title,
      "description": book.description,
      "imageUrl": book.imageUrl,
      "author": book.author
    });
  }

  List<Book> _bookFromQuerySnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.data);
      return Book(
          rating: doc.data()['rating'],
          isOwned: doc.data()['isOwned'],
          isBookMarked: doc.data()['isBookMarked'],
          imageUrl: doc.data()['imageUrl'],
          title: doc.data()['title'],
          isbn: doc.data()['isbn'],
          author: doc.data()['author'],
          description: doc.data()['description']);
    }).toList();
  }

  //get Book data from stream with uid
  // Stream<List<Book>> get booksData {
  //   return booksCollection.snapshots().map((_bookFromQuerySnapShot));
  // }

  //Read from firestore
  Stream<List<Book>> get booksData {
    return booksCollection.doc(uid).collection("ownedBooks").snapshots().map((_bookFromQuerySnapShot));
  }

  //*********Updates***************//
  //1.0->Update Rating a book by giving Star
  updateRating(double star, String isbn) {
    booksCollection.doc(uid).collection("ownedBooks").doc(isbn).set({
      "rating": star,
    }, SetOptions(merge: true)).then((_) => print("Done"));
  }

  //2.0->Update BookMark toggle bookmark
  updateBookMark(Book book) {
    //Get
    var docReference = booksCollection.doc(uid).collection("ownedBooks").doc(book.isbn);
    docReference
        .get()
        .then((doc) => {
              if (doc.exists)
                {
                  docReference.set({
                    "isBookMarked": book.isBookMarked,
                  }, SetOptions(merge: true))
                }
              else
                {addBook(book)}
            })
        .catchError((e) {
      print(e.toString());
    });
  }

  removeBook(String isbn) {
    booksCollection.doc(uid).collection("ownedBooks").doc(isbn).delete().catchError((e) => print(e.toString()));
  }

  Future sendMessage(Message message) async {
    // final newMessage = Message(
    //   from: myUID,
    //   to: receiverUID,
    //   message: message,
    //   createdAt: DateTime.now(),
    // );

    //Sender sends a message
    await chatCollection
        .doc(message.sender)
        .collection('conversation')
        .doc(message.receiver)
        .collection('messages')
        .add({"sender": message.sender, "receiver": message.receiver, "message": message.message, "createdAt": message.createdAt});
    // Message(
    //   sender: doc.data()['sender'],
    //   receiver: doc.data()['receiver'],
    //   message: doc.data()['message'],
    //   createdAt: doc.data()['createdAt'],
    // );
    //update receiver inbox
    await chatCollection
        .doc(message.receiver)
        .collection('conversation')
        .doc(message.sender)
        .collection('messages')
        .add({"sender": message.sender, "receiver": message.receiver, "message": message.message, "createdAt": message.createdAt});
  }

  Stream<QuerySnapshot> getMessageStream(String from, String to) {
    return chatCollection
        .doc(from)
        .collection('conversation')
        .doc(to)
        .collection('messages')
        .orderBy('createdAt', descending: false) //
        .snapshots();
    // .map(_messageFromSnapshot);
  }

  //**End of DB service
}
