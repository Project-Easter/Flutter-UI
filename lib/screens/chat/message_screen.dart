import 'package:books_app/Screens/Chat/message_bubble.dart';
import 'package:books_app/Utils/size_config.dart';
import 'package:books_app/models/message.dart';
import 'package:books_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const BoxDecoration kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const InputDecoration kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const TextStyle kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const InputDecoration kTextFieldDecoration = InputDecoration(
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

class MessageScreen extends StatelessWidget {
  final UserData receiver;
  const MessageScreen({this.receiver});
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageTextController = TextEditingController();
    String messageText;
    final User user = FirebaseAuth.instance.currentUser;
    print(user.uid);
    // final DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
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
                      onChanged: (String value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final Message newMessage = Message(
                        sender: user.uid,
                        receiver: receiver.uid,
                        message: messageText,
                        createdAt: DateTime.now(),
                      );
                      messageTextController.clear();
                      // _databaseService.sendMessage(newMessage);
                    },
                    child: const Text(
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

  const MessageStream({this.sender, this.receiver});
  @override
  Widget build(BuildContext context) {
    // final DatabaseService _databaseService = DatabaseService(uid: sender);
    return StreamBuilder<QuerySnapshot>(
      // stream: _databaseService.getMessageStream(sender, receiver),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }

        final Iterable<QueryDocumentSnapshot> messages =
            snapshot.data.docs.reversed;
        final List<MessageBubble> messageBubbles = <MessageBubble>[];
        for (final QueryDocumentSnapshot message in messages) {
          final DateTime dateTime = message.data()['createdAt'] as DateTime;
          final String messageText = message.data()['message'] as String;
          final String messageSender = message.data()['sender'] as String;
          final MessageBubble messageBubble = MessageBubble(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
