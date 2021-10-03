import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/books.dart';
import 'package:books_app/screens/dashboard/book_list.dart';
import 'package:books_app/screens/dashboard/quotes.dart';
import 'package:books_app/screens/dashboard/user_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class GoogleBooks extends StatefulWidget {
  final String? title;
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
            Quotation(),
            UserChoice(),
            const GoogleBooks(title: 'Discover New '),
          ],
        ),
      ),
    );
  }
}

class _GoogleBooksState extends State<GoogleBooks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: Provider.of<Books>(context, listen: false).topBooks(),
        builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print('$snapshot.data is the Google book snap');
            // Extracting data from snapshot object
            final List<Book> recommendedBooksML = snapshot.data as List<Book>;
            return BookList(widget.title!, recommendedBooksML);
          }
        });
  }
}
