import 'package:books_app/Services/database_service.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/models/user.dart';
import 'package:books_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class UserTile extends StatelessWidget {
  final UserData userData;
  const UserTile({Key key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.Hm();
    final String formattedDate = formatter.format(now);
    // print(formattedDate); // 2016-01-25
    return Card(
      child: ListTile(
        title: Text(userData.displayName),
        subtitle: Text(userData.city),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            userData.photoURL,
          ),
        ),
        trailing: Column(
          children: <Widget>[
            Text(
              // chat.time,
              formattedDate,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            // chat.unread
            //     ?
            Container(
              width: 40.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              alignment: Alignment.center,
              child: const Text(
                'NEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // : Text(''),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, Routes.MESSAGE, arguments: userData);
        },
      ),
    );
  }
}

class _ChatRoomState extends State<ChatRoom> {
  final AuthService _authService = AuthService();

  List<UserData> allUser = [];
  @override
  Widget build(BuildContext context) {
    final String uID = _authService.getUID as String;
    final UserData currentUser = Provider.of<UserData>(context);
    return Scaffold(
      //TODO:Remove this stream.This is dummy stream for chat. Replace this with conversations stream
      body: StreamBuilder<List<UserData>>(
          stream: DatabaseService(uid: uID).allUsers,
          builder:
              (BuildContext context, AsyncSnapshot<List<UserData>> snapshot) {
            if (snapshot.hasData) {
              allUser = snapshot.data;
              return SingleChildScrollView(
                child: ListView.builder(
                  //Fix unbounded Height
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  //
                  itemBuilder: (BuildContext context, int index) {
                    for (final UserData users in allUser) {
                      if (users.uid != currentUser.uid) {
                        // print(users.uid);
                        // print(allUser[index].longitude);
                        // print(allUser[index].latitude);
                      }
                    }
                    return allUser[index].uid != uID
                        ? UserTile(
                            userData: allUser[index],
                          )
                        : const SizedBox.shrink();
                  },
                  itemCount: allUser.length,
                ),
              );
            } else {
              return const Center(
                child: Text('Nothing here'),
              );
            }
          }),
    );
  }
}
