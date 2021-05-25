import 'package:books_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Constants/routes.dart';
import '../../../Models/user.dart';
import '../../../Services/database_service.dart';
import 'package:intl/intl.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final AuthService _authService = AuthService();

  // return StreamBuilder<UserData>(
  // stream: DatabaseService(uid: uID).userData,
  // builder: (context, snapshot) {
  // if (snapshot.hasData) {

  List<UserData> allUser = [];
  @override
  Widget build(BuildContext context) {
    final String uID = _authService.getUID as String;
    final currentUser = Provider.of<UserData>(context);
    return Scaffold(
      //TODO:Remove this stream.This is dummy stream for chat. Replace this with conversations stream
      body: StreamBuilder<List<UserData>>(
          stream: DatabaseService(uid: uID).allUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              allUser = snapshot.data;
              return SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                    //Fix unbounded Height
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    //
                    itemBuilder: (context, index) {
                      for (UserData users in allUser) {
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
                          : SizedBox.shrink();
                    },
                    itemCount: allUser.length,
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("Nothing here"),
              );
            }
          }),
    );
  }
}

class UserTile extends StatelessWidget {
  final UserData userData;
  const UserTile({Key key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat.Hm();
    String formattedDate = formatter.format(now);
    // print(formattedDate); // 2016-01-25
    return Container(
      child: Card(
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
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
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
                child: Text(
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
      ),
    );
  }
}

// class RecentChats extends StatelessWidget {
//   final UserData userData;
//   RecentChats({Key key, this.userData}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
//       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         // : Colors.white,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20.0),
//           bottomRight: Radius.circular(20.0),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               CircleAvatar(
//                 radius: 35.0,
//                 backgroundImage: NetworkImage(
//                   userData.photoURL,
//                 ),
//               ),
//               SizedBox(width: 10.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     userData.displayName,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5.0),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.45,
//                     child: Text(
//                       // chat.text,
//                       "Hello",
//                       style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Column(
//             children: <Widget>[
//               Text(
//                 // chat.time,
//                 DateTime.now().toString(),
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 5.0),
//               // chat.unread
//               //     ?
//               Container(
//                 width: 40.0,
//                 height: 20.0,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'NEW',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               // : Text(''),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// String formatter = DateFormat('yMd').format(now); // 28/03/2020
