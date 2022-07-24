import 'dart:async';
import 'package:books_app/screens/user_preferences.dart';
import 'package:books_app/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String chatRoomId;
  final String displayName;

  const ChatPage({required this.chatRoomId, required this.displayName});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  Widget chatMessages() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.chatRoomId)
          .collection('messages')
          .orderBy('time')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        return snapshot.hasData
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.74,
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageTile(
                        message: snapshot.data!.docs[index]
                            .data()['message']
                            .toString(),
                        sendByMe:
                            uID == snapshot.data!.docs[index].data()['sendBy'],
                      );
                    }),
              )
            : Container();
      },
    );
  }

  void addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      final Map<String, dynamic> chatMessageMap = <String, dynamic>{
        'sendBy': uID,
        'message': messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      ChatService().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = '';
      });
    }
  } //add message to chat

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      Timer(const Duration(milliseconds: 200), () => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.displayName),
        elevation: 0.1,
      ),
      body: Stack(
        children: [
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageEditingController,
                    // style: simpleTextStyle(),
                    decoration: const InputDecoration(
                        hintText: 'Message ...',
                        hintStyle: TextStyle(
                          color: Color(0xff007EF4),
                          fontSize: 16,
                        ),
                        border: InputBorder.none),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      addMessage();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(Icons.send)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  const MessageTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? const EdgeInsets.only(left: 30) : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0xff1F313B), const Color(0xFF1F313B)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
