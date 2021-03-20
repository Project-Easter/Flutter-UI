import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/user.dart';
import '../Models/book.dart';

//**Note this Database is for TEST.
//**Need to migrate this App to REST
//Using cloud Firestore for this Test
class DatabaseService {
  //Get uid from Register/signin

  final String uid;
  DatabaseService({this.uid});
  //collection references here

  //Users collection
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');
  //Books collection
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  //TODO:Save User Data in firebase and a local object
  //TODO:Add USERDATA and BOOKS Stream
  Future updateUserData(UserData userData) async {
    return await userDataCollection.doc(uid).set(
      {
        "uid": userData.uid,
        "displayName": userData.displayName,
        "email": userData.email,
        "emailVerified": userData.emailVerified,
        //this is not required.Just for test purpose
        "isAnonymous": userData.isAnonymous,
        "phoneNumber": userData.phoneNumber,
        "photoURL": userData.photoURL,
        "city": userData.city,
        "state": userData.state
      },
      //TODO:Check How many writes with this
      // SetOptions(merge: true)
    );
  }

  //Get UserData Stream
  // Stream<QuerySnapshot> get userData {
  //   return userDataCollection.snapshots();
  // }

  //Get UserData Stream From FireBase with UID
  // Stream<DocumentSnapshot> get userData {
  //   return userDataCollection.doc(uid).snapshots(_userDataFromSnapShot);
  // }

  //Convert StreamData to UserData Model
  // UserData _userDataFromSnapShot(DocumentSnapshot documentSnapshot) {
  //   return UserData(
  //     uid: documentSnapshot.data()['uid'],
  //     displayName: documentSnapshot.data()['displayName'],
  //     email: documentSnapshot.data()['email'],
  //     phoneNumber: documentSnapshot.data()['phoneNumber'],
  //   );
  // }

  //Update User Data from Edit Screen

  Future updateUser(String name, String city, String state) async {
    return await userDataCollection.doc(uid).set({
      "city": city,
      "state": state,
      "displayName": name,
    }, SetOptions(merge: true));
  }

  UserData _userDataFromSnapShot(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: uid,
      // uid: documentSnapshot.data()['uid'],
      displayName: documentSnapshot.data()['displayName'] ?? "Enter Name",
      email: documentSnapshot.data()['email'] ?? "example@example.com",
      phoneNumber: documentSnapshot.data()['phoneNumber'] ?? "8844883333",
      state: documentSnapshot.data()['state'],
      city: documentSnapshot.data()['city'],
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

  //*********Books***********//

  // Sample 10 digit ISBN to ADD

  //8176561061
  //0764526413
  //0136091814

  //Add Book to collection
  Future addBook(Book book) async {
    //GET BOOK FROM API or an existing List
    return await booksCollection
        .doc(uid)
        .collection('ownedBooks')
        .doc(book.isbn)
        .set({
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
      print(doc.data);
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
    return booksCollection
        .doc(uid)
        .collection("ownedBooks")
        .snapshots()
        .map((_bookFromQuerySnapShot));
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
    var docReference =
        booksCollection.doc(uid).collection("ownedBooks").doc(book.isbn);
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
        .catchError((e) => print(e.toString()));
  }

  //Delete book
  removeBook(String isbn) {
    booksCollection
        .doc(uid)
        .collection("ownedBooks")
        .doc(isbn)
        .delete()
        .catchError((e) => print(e.toString()));
  }

  //Chat and List all Users
//TODO:Get All users from firebase to a List and display on chat screen
  Stream<QuerySnapshot> get getAllUsers {}

  //**End of DB service
}
