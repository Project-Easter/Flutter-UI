import 'package:books_app/screens/chat_page.dart';
import 'package:books_app/screens/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatService {
  final CollectionReference<Map<String, dynamic>> userDataCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> chatsCollection =
      FirebaseFirestore.instance.collection('chats');

  Future<bool> createNewChat(String recipient, BuildContext context) async {
    if (await checkIfChatExist(recipient)) return false;
    String displayName = 'Unknown';
    await userDataCollection.doc(uID).get().then((DocumentSnapshot value) {
      List<dynamic> users = <String>[];
      try {
        users = value['chat'] as List<dynamic>;
      } catch (e) {
        print('no field found');
      }
      if (!users.contains(recipient)) {
        users.add(recipient);
        userDataCollection.doc(uID).set(
            <String, List<dynamic>>{'chat': users}, SetOptions(merge: true));
      }
    });

    await userDataCollection
        .doc(recipient)
        .get()
        .then((DocumentSnapshot value) {
      List<dynamic> users = <String>[];
      try {
        users = value['chat'] as List<dynamic>;
      } catch (e) {
        print('no field found');
      }
      displayName = value['displayName'].toString();
      if (!users.contains(uID)) {
        users.add(uID);
        userDataCollection.doc(recipient).set(
            <String, List<dynamic>>{'chat': users}, SetOptions(merge: true));
      }
    });

    final String chatRoomId = getChatRoomId(recipient);
    await chatsCollection
        .doc(chatRoomId)
        .collection('messages')
        .add(<String, dynamic>{'chats created at': DateTime.now()});
    await chatsCollection.doc(chatRoomId).set(<String, dynamic>{
      'chatRoomId': chatRoomId,
      'users': [uID, recipient]
    });
    Navigator.of(context).push(MaterialPageRoute<ChatPage>(
        builder: (BuildContext context) =>
            ChatPage(chatRoomId: chatRoomId, displayName: displayName)));
    return true;
  }

  Future<bool> checkIfChatExist(String recipient) async {
    final String chatRoomId = getChatRoomId(recipient);
    DocumentSnapshot<Map<String, dynamic>> doc =
        await chatsCollection.doc(chatRoomId).get();
    if (!doc.exists) {
      print('No such document exista!');
      return false;
    } else {
      print('Document data:' + doc.data().toString());
      return true;
    }
  }

  String getChatRoomId(String recipient) {
    final String uid = uID;
    if (uid.compareTo(recipient) < 0) {
      return uid + '_' + recipient;
    } else {
      return recipient + '_' + uid;
    }
  }

  void addMessage(String chatRoomId, Map<String, dynamic> chatMessageData) {
    chatsCollection.doc(chatRoomId).collection('messages').add(chatMessageData);
  }

  void openExistingChat(String recipient, BuildContext context) async {
    String chatRoomId = getChatRoomId(recipient);
    String displayName = 'Unknown';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(recipient)
        .get()
        .then((DocumentSnapshot value) {
      displayName = value['displayName'].toString();
      print(displayName);
    });
    Navigator.of(context).push(MaterialPageRoute<ChatPage>(
        builder: (BuildContext context) =>
            ChatPage(chatRoomId: chatRoomId, displayName: displayName)));
  }
}
