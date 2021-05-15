import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Screens/dashboard/Dashboard.dart';
import 'package:books_app/Screens/bookshelf.dart';
import 'package:books_app/Screens/explore_nearby.dart';
import 'package:books_app/Screens/Profile/private_profile.dart';
import 'package:books_app/Services/databaseService.dart';
import 'package:books_app/Widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books_app/Widgets/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Utils/size_config.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/Models/user.dart';
import 'package:books_app/Models/book.dart';
import 'Chat/wrapper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _Screens = [
    DashboardPage(),
    ExploreNearby(),
    Wrapper(),
    LibraryPage(),
    PrivateProfile(),
  ];
  TextStyle name = GoogleFonts.muli(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);
  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    //Setup Size Config-starting of app
    SizeConfig().init(context);
    final uID = _authService.getUID;
    print(uID);
    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(
          value: DatabaseService(uid: uID).userData,
          catchError: (_, e) => null,
        ),
        //TODO:SETUP STREAM PROVIDER For DatabaseService
        StreamProvider<List<Book>>.value(value: DatabaseService(uid: uID).booksData),
      ],
      child: Scaffold(
          appBar: MyAppBar(context),
          body: _Screens[_selectedIndex],
          floatingActionButton: Container(
            child: _selectedIndex == 3 || _selectedIndex == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          heroTag: null,
                          child: Icon(Icons.add_box_rounded),
                          onPressed: () {
                            Navigator.pushNamed(context, addBook);
                          },
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: 'map',
                        child: Icon(Icons.location_on),
                        backgroundColor: Colors.blueAccent,
                        onPressed: () async {
                          //Add users Location to DB
                          await Navigator.pushNamed(context, location);
                        },
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ),
          bottomNavigationBar: FloatingNavbar(
            showSelectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: _selectedTab,
            showUnselectedLabels: true,
            items: [
              FloatingNavbarItem(
                icon: Icons.home_filled,
                title: 'Home',
              ),
              FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
              FloatingNavbarItem(icon: Icons.chat_bubble_rounded, title: 'Chats'),
              FloatingNavbarItem(icon: Icons.favorite_rounded, title: 'Library'),
              FloatingNavbarItem(icon: Icons.account_circle_rounded, title: 'Profile'),
            ],
          )),
    );

    // return StreamProvider<UserData>.value(
    //   value: DatabaseService(uid: uID).userData,
    //   child: Scaffold(
    //       appBar: MyAppBar(context),
    //       body: _Screens[_selectedIndex],
    //       floatingActionButton: Container(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: FloatingActionButton(
    //                 heroTag: null,
    //                 child: Icon(Icons.add_box_rounded),
    //                 onPressed: () {
    //                   Navigator.pushNamed(context, addBook);
    //                 },
    //               ),
    //             ),
    //             FloatingActionButton(
    //               heroTag: 'map',
    //               child: Icon(Icons.location_on),
    //               backgroundColor: Colors.blueAccent,
    //               onPressed: () {
    //                 Navigator.pushNamed(context, location);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //       bottomNavigationBar: FloatingNavbar(
    //         showSelectedLabels: true,
    //         currentIndex: _selectedIndex,
    //         onTap: _selectedTab,
    //         showUnselectedLabels: true,
    //         items: [
    //           FloatingNavbarItem(
    //             icon: Icons.home_filled,
    //             title: 'Home',
    //           ),
    //           FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
    //           FloatingNavbarItem(
    //               icon: Icons.chat_bubble_rounded, title: 'Chats'),
    //           FloatingNavbarItem(
    //               icon: Icons.favorite_rounded, title: 'Library'),
    //           FloatingNavbarItem(
    //               icon: Icons.account_circle_rounded, title: 'Profile'),
    //         ],
    //       )),
    // );
  }
}