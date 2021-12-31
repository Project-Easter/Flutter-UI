import 'package:books_app/screens/chat_page.dart';
import 'package:books_app/screens/user_preferences.dart';
import 'package:books_app/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic>? recipientList = <String>[];
  bool isLoading = true;
  @override
  void initState() {
    getRecipientList();
    super.initState();
  }

  Future<void> getRecipientList() async {
    recipientList!.clear();
    await FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: uID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (QueryDocumentSnapshot<Object?> doc in querySnapshot.docs) {
        List<dynamic> users = doc['chatRoomId'].toString().split('_');
        users.remove(uID);
        final String recipientId = users.first.toString();
        print('recipient : ' + recipientId);
        recipientList!.add(recipientId);
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 35,
          child: const Center(
            child: Text(
              'Chats',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        if (recipientList != null)
          ListView.builder(
            shrinkWrap: true,
            itemCount: recipientList!.length,
            itemBuilder: (BuildContext context, int index) {
              if (recipientList != null) {
                return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(recipientList![index].toString())
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GestureDetector(
                          onTap: () {
                            final String chatRoomId = ChatService()
                                .getChatRoomId(
                                    recipientList![index].toString());
                            Navigator.of(context)
                                .push(MaterialPageRoute<ChatPage>(
                                    builder: (BuildContext context) => ChatPage(
                                          chatRoomId: chatRoomId,
                                          displayName: snapshot
                                              .data!['displayName']
                                              .toString(),
                                        )));
                          },
                          child: ListTile(
                            title:
                                Text(snapshot.data!['displayName'].toString()),
                            subtitle: const Text('Tap to view message'),
                            leading: snapshot.data!['photoURL']
                                    .toString()
                                    .startsWith('assets')
                                ? Image.asset(
                                    snapshot.data!['photoURL'].toString(),
                                    scale: 1.4,
                                  )
                                : Image.network(
                                    snapshot.data!['photoURL'].toString(),
                                    scale: 1.4),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    });
              } else {
                return SizedBox(
                  child: Text(
                    "No chats Yet",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            },
          )
        else
          Center(
            child: Text(
              'No Chats Yet',
              style: TextStyle(color: Colors.black),
            ),
          ),
      ],
    );
  }
}
