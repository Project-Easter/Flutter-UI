import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrivateProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserData profileData = Provider.of<UserData>(context);
    final List<Book> booksData = Provider.of<List<Book>>(context);
    final FirebaseAuthService firebaseAuthService =
        Provider.of<FirebaseAuthService>(context);
    // final UserData profileData =Provider.of<UserData>(context);
    int ownedBooksLength;
    if (booksData.isEmpty) {
      ownedBooksLength = 0;
    } else {
      ownedBooksLength =
          booksData.where((Book book) => book.isOwned == true).length;
    }
    final List<Book> ownedBooks = <Book>[];
    for (Book book in booksData) {
      if (book.isOwned == true) {
        ownedBooks.add(book);
      }
    }
    final List<Book> savedBooks = <Book>[];
    for (Book book in booksData) {
      if (book.isBookMarked == true) {
        savedBooks.add(book);
      }
    }

    if (profileData == null || booksData == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ProfileHeader(profileData: profileData),
              const Divider(
                  // color: Colors.black54,
                  ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'User Stats',
                      style: GoogleFonts.poppins(
                          // color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(ownedBooksLength.toString(),
                                style: GoogleFonts.poppins(
                                    // color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            const Text('Owned Books')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('0',
                                // borrowedBooksLength,
                                style: GoogleFonts.poppins(
                                    // color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            const Text('Borrowed Books')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('0',
                                // lentBooksLength,
                                style: GoogleFonts.poppins(
                                    // color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400)),
                            const Text('Lent Books')
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Button(
                      name: 'Add your Book',
                      myFunction: () async {
                        Navigator.pushNamed(context, Routes.ADD_BOOK);
                      },
                    ),
                    Button(
                        name: 'Logout',
                        color: Theme.of(context).colorScheme.onSecondary,
                        textColor: Colors.white,
                        myFunction: () async {
                          firebaseAuthService.signOut();
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class ProfileHeader extends StatelessWidget {
  final UserData profileData;

  const ProfileHeader({
    Key? key,
    required this.profileData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserModel>(context).fetchUserData();
    return Consumer<UserData>(
        builder: (BuildContext context, UserData profile, _) {
      return Column(
        children: <Widget>[
          Container(
            width: 300,
            padding: const EdgeInsets.all(5),
            child: profile.photoURL!.startsWith('assets')
                ? CircleAvatar(
                    radius: 100,
                    child: Image.asset(
                      'assets/images/Explr Logo.png',
                      fit: BoxFit.contain,
                    ),
                  )
                : CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(profile.photoURL!),
                  )

            // NetworkImage(profile.photoURL),
            ,
          ),
          Text(
            profile.displayName!,
            style:
                GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                (profileData.city != null || profileData.streetAddress != null)
                    ? '${profileData.streetAddress} , ${profileData.city}'
                    : 'Update your location by pressing on the floating action button at the bottom right corner',
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    });
  }
}
