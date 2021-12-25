import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 7,
          itemBuilder: (BuildContext ctx, int idx) => Container(
                padding: const EdgeInsets.all(5),
                child: Text('Chat testing'),
              )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            //We'll fetch data from Firestore here
            //So with this, we're telling Firestore that we want to get access to the messages collection inside the chat collection
            FirebaseFirestore.instance
                .collection('chats/gJIMmk9z08nPa2Y3cYJ8/messages')
                .snapshots()
                .listen((QuerySnapshot<Map<String, dynamic>> event) {
              print(event.docs[0]['text']);
              event.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {print(element['text']);});
            });
          }),
    );
  }
}
