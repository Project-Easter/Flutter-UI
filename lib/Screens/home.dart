import 'package:books_app/Screens/Dashboard.dart';
import 'package:books_app/Screens/book_desciption.dart';
import 'package:books_app/Screens/bookshelf.dart';
import 'package:books_app/Screens/chat_screen.dart';
import 'package:books_app/Screens/explore_nearby.dart';
import 'package:books_app/Screens/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books_app/Widgets/custom_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    DashboardPage(),
    ExploreNearby(),
    ChatScreen(),
    MyBookshelf(),
    ProfilePage(),
    BookDescription(),
  ];
  TextStyle name = GoogleFonts.muli(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);
  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
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
            FloatingNavbarItem(
                icon: Icons.account_circle_rounded, title: 'Profile'),
          ],
        ));
  }
}
