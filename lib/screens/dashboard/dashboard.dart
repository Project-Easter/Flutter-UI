import 'package:books_app/Screens/dashboard/book_list.dart';
import 'package:books_app/Screens/dashboard/quotes.dart';
import 'package:books_app/Screens/dashboard/user_choice.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/models/books.dart';
import 'package:books_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class UserChoiceBooks extends StatelessWidget {
  final String title;
  const UserChoiceBooks({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: Provider.of<Books>(context, listen: false).topBooks(),
        // ignore: always_specify_types
        builder: (ctx, snapshot) {
          // Checking if future is resolved
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.toString());
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: const TextStyle(fontSize: 18),
                ),
              );
              // if we got our data
            } else if (snapshot.hasData) {
              print(snapshot);
              // Extracting data from snapshot object
              final List<Book> recommendedBooksML = snapshot.data as List<Book>;
              return BookList(title, recommendedBooksML);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        //  ... some code here
        );
  }
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // var discoverNew = Provider.of<Books>(context).discoverNew;
    // var recommendedBooks = Provider.of<Books>(context).recommendedBooks;
    final UserData userData = Provider.of<UserData>(context);
    print(userData);
    return Scaffold(
      body: SingleChildScrollView(
        // ignore: prefer_const_constructors
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Quotes(),
            const UserChoice(),
            // BookList('Discover New', discoverNew),
            // BookList('Recommended for you', recommendedBooks),
            const UserChoiceBooks(title: 'Based on your Interest'),
            const UserChoiceBooks(title: 'Discover New '),
            // const UserChoiceBooks(title: 'Recommended for you'),
          ],
        ),
      ),
    );
  }
}
