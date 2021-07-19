import 'package:books_app/widgets/empty_page.dart';
import 'package:flutter/material.dart';

class BookRequest extends StatefulWidget {
  @override
  _BookRequestState createState() => _BookRequestState();
}

class _BookRequestState extends State<BookRequest> {
  @override
  Widget build(BuildContext context) {
    return const EmptyPageWidget(headline: 'No Book Requests');
  }
}
