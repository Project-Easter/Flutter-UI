import 'package:books_app/Screens/dashboard/book_list.dart';
import 'package:books_app/Screens/dashboard/quotes.dart';
import 'package:books_app/Screens/dashboard/user_choice.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/models/books.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class GoogleBooks extends StatefulWidget {
  final String title;
  const GoogleBooks({this.title});

  @override
  _GoogleBooksState createState() => _GoogleBooksState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Quotes(),
            const UserChoice(),
            const GoogleBooks(title: 'Discover New '),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class _GoogleBooksState extends State<GoogleBooks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: Provider.of<Books>(context, listen: false).topBooks(),
        builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
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
              return BookList(widget.title, recommendedBooksML);
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
        });
  }
}
