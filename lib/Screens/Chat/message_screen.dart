import 'package:books_app/Screens/Chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:books_app/Models/user.dart';
import 'package:books_app/Models/message.dart';
import 'package:books_app/Services/database_service.dart';
import 'package:books_app/Utils/size_config.dart';

class MessageScreen extends StatelessWidget {
  final UserData receiver;
  MessageScreen({this.receiver});
  @override
  Widget build(BuildContext context) {
    final messageTextController = TextEditingController();
    String messageText;
    final user = FirebaseAuth.instance.currentUser;
    print(user.uid);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(receiver.photoURL),
            ),
            SizedBox(
              width: getProportionateScreenWidth(20),
            ),
            Text(receiver.displayName)
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              sender: user.uid,
              receiver: receiver.uid,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Message newMessage = Message(
                        sender: user.uid,
                        receiver: receiver.uid,
                        message: messageText,
                        createdAt: DateTime.now(),
                      );
                      messageTextController.clear();
                      _databaseService.sendMessage(newMessage);
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  final String sender;
  final String receiver;

  MessageStream({this.sender, this.receiver});
  @override
  Widget build(BuildContext context) {
    DatabaseService _databaseService = DatabaseService(uid: sender);
    return StreamBuilder<QuerySnapshot>(
      stream: _databaseService.getMessageStream(sender, receiver),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong."),
          );
        }

        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final DateTime dateTime =
              message.data()['createdAt'].toDate() as DateTime;
          final String messageText = message.data()['message'] as String;
          final String messageSender = message.data()['sender'] as String;
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: sender == messageSender,
            dateTime: dateTime,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
