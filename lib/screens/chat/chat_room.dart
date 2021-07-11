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
          Navigator.pushNamed(context, 'EMPTY: MESSAGE_SCREEN',
              arguments: userData);
        },
      ),
    );
  }
}

class _ChatRoomState extends State<ChatRoom> {
  List<UserData> allUser = <UserData>[];
  @override
  Widget build(BuildContext context) {
    final dynamic uID = AuthService().getUID;
    final UserData currentUser = Provider.of<UserData>(context);

    if (currentUser.isAnonymous == true) {
      return const Scaffold(
        body: Center(
          child: Text('Login to continue'),
        ),
      );
    }
    return Scaffold(
      body: StreamBuilder<List<UserData>>(
          // stream: DatabaseService(uid: uID as String).allUsers,
          builder:
              (BuildContext context, AsyncSnapshot<List<UserData>> snapshot) {
        if (snapshot.hasData) {
          allUser = snapshot.data;
          return SingleChildScrollView(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
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
