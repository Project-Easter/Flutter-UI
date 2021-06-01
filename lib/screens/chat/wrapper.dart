import 'package:books_app/Screens/Chat/chat_room/chat_room.dart';
import 'package:books_app/Screens/book_request.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        print('Current Index: ${DefaultTabController.of(context).index}');
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 50.0,
              child: TabBar(
                onTap: (value) {
                  print(value);
                },
                tabs: [
                  const Tab(
                    icon: Icon(
                      Icons.message,
                      color: Colors.grey,
                    ),
                  ),
                  const Tab(
                    icon: Icon(Icons.book, color: Colors.grey),
                  ),
                ],
                //
                indicator: const BoxDecoration(
                  color: Colors.white,
                ),
                unselectedLabelColor: const Color(0xffff00a8),
                indicatorColor: const Color(0xffff00a8),
                labelColor: const Color(0xffffffff),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ChatRoom(),
              BookRequest(),
            ],
          ),
        );
      }),
    );
  }
}
