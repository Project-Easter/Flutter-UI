import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books_app/models/books.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/models/user.dart';
import 'book_list.dart';
import 'user_choice.dart';
import 'quotes.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // var discoverNew = Provider.of<Books>(context).discoverNew;
    // var recommendedBooks = Provider.of<Books>(context).recommendedBooks;
    final userData = Provider.of<UserData>(context);
    print(userData);
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Quotes(),
            UserChoice(),
            // BookList('Discover New', discoverNew),
            // BookList('Recommended for you', recommendedBooks),
            UserChoiceBooks(title: 'Based on your Interest'),
            UserChoiceBooks(title: 'Discover New '),
            UserChoiceBooks(title: 'Recommended for you'),
          ],
        ),
      ),
    );
  }
}

class UserChoiceBooks extends StatelessWidget {
  final String title;
  UserChoiceBooks({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Books>(context, listen: false).getRecommendedBooks("test"),
        builder: (ctx, snapshot) {
          // Checking if future is resolved
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final List<Book> recommendedBooksML = snapshot.data;
              return BookList(title, recommendedBooksML);
            } else {
              return SizedBox.shrink();
            }
          } else {
            return Container();
          }
        }
        //  ... some code here
        );
  }
}
