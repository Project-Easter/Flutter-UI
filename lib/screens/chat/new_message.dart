import 'package:books_app/Services/database_service.dart';
import 'package:books_app/models/message.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String from;
  final String to;
  NewMessage({this.from, this.to});
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Type your message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  gapPadding: 8,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: (value) => setState(() {
                message = value;
              }),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: message.trim().isEmpty ? null : sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage() async {
    FocusScope.of(context).unfocus();
    // await FirebaseApi.uploadMessage(widget.idUser, message);
    final Message messageData = Message(
        sender: widget.from,
        receiver: widget.to,
        message: message,
        createdAt: DateTime.now());
    await DatabaseService(uid: widget.from).sendMessage(messageData);
    _controller.clear();
  }
}
