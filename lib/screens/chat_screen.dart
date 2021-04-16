import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // final querySnapshot = Provider.of<QuerySnapshot>(context);
    // print(querySnapshot);
    return Scaffold(
      body: Center(
        child: Text('Welcome to Chat Screen'),
      ),
    );
  }
}
