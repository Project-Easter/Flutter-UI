
import 'package:books_app/utils/keys_storage.dart';
import 'package:books_app/Widgets/custom_navigation_bar.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/screens/bookshelf.dart';
import 'package:books_app/screens/chat/wrapper.dart';
import 'package:books_app/screens/dashboard/dashboard.dart';
import 'package:books_app/screens/explore_nearby.dart';
import 'package:books_app/screens/profile/private_profile.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
import 'package:books_app/utils/size_config.dart';
import 'package:books_app/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _screens = <Widget>[
    DashboardPage(),
    ExploreNearby(),
    const Wrapper(),
    LibraryPage(),
    PrivateProfile(),
  ];

  TextStyle name = GoogleFonts.muli(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);
  final FirebaseAuthService _authService =
      FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String uID = _authService.getUID;
    print(uID);

    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(
          value: DatabaseService(uid: uID).userData,
          catchError: (_, Object e) => null,
        ),
        StreamProvider<List<Book>>.value(
          value: DatabaseService(uid: uID).booksData,
        ),
      ],
      child: Scaffold(
          appBar: MyAppBar(context),
          body: _screens[_selectedIndex],
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FloatingActionButton(
              //     heroTag: null,
              //     child: const Icon(Icons.add_box_rounded),
              //     onPressed: () {
              //       Navigator.pushNamed(context, Routes.ADD_BOOK);
              //     },
              //   ),
              // ),
              FloatingActionButton(
                heroTag: 'map',
                child: const Icon(Icons.location_on),
                backgroundColor: Colors.blueAccent,
                onPressed: () async {
                  await Navigator.pushNamed(context, Routes.LOCATION);
                },
              ),
            ],
          ),
          bottomNavigationBar: FloatingNavbar(
            showSelectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: _selectedTab,
            showUnselectedLabels: true,
            items: <FloatingNavbarItem>[
              FloatingNavbarItem(
                icon: Icons.home_filled,
                title: 'Home',
              ),
              FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
              FloatingNavbarItem(
                  icon: Icons.chat_bubble_rounded, title: 'Chats'),
              FloatingNavbarItem(
                  icon: Icons.favorite_rounded, title: 'Library'),
              FloatingNavbarItem(
                  icon: Icons.account_circle_rounded, title: 'Profile'),
            ],
          )),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }

  @override
  void initState() {
    
    super.initState();
  }

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
