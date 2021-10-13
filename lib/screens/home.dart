import 'package:books_app/constants/colors.dart';
import 'package:books_app/providers/book.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/screens/bookshelf.dart';
import 'package:books_app/screens/chat.dart';
import 'package:books_app/screens/dashboard/dashboard.dart';
import 'package:books_app/screens/explore_nearby.dart';
import 'package:books_app/screens/profile/private_profile.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
import 'package:books_app/utils/keys_storage.dart';
import 'package:books_app/utils/location_helper.dart';
import 'package:books_app/utils/size_config.dart';
import 'package:books_app/widgets/app_bar.dart';
import 'package:books_app/widgets/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
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
    ChatScreen(),
    LibraryPage(),
    PrivateProfile(),
  ];

  // TextStyle name = GoogleFonts.muli(
  //     color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);
  final FirebaseAuthService _authService = FirebaseAuthService();
  TokenStorage _tokenStorage = TokenStorage();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final String uID = _authService.getUID;
    final DatabaseService _databaseService =
        DatabaseService(uid: uID.toString());
    print(uID);
    final LocationHelper _locationHelper = LocationHelper();
    print(uID);

    return MultiProvider(
      providers: <StreamProvider<dynamic>>[
        StreamProvider<UserData>.value(
          value: _databaseService.userData,
          catchError: (_, Object e) => null,
        ),
        StreamProvider<List<Book>>.value(
          value: _databaseService.booksData,
        ),
        
      
      ],
      child: Scaffold(
          appBar: MyAppBar(context),
          body: _screens[_selectedIndex],
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'map',
                child: Icon(
                  Icons.location_on,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                // backgroundColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  // we are not navigating to the map anymore.
                  // await Navigator.pushNamed(context, Routes.LOCATION);

                  // get lat/long
                  await _locationHelper
                      .getCurrentLocation()
                      .then((LatLng value) async {
                    // updating address using lat/long
                    await _databaseService
                        .updateUserLocation(value.latitude, value.longitude)
                        .then((dynamic value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: blackButton,
                        content: Text('Location Updated Successfully!'),
                      ));
                    });
                  }).onError((String error, StackTrace stackTrace) {
                    print(error);
                    print(stackTrace);
                    SnackBar(content: Text(error.toString()));
                  });
                },
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow:<BoxShadow> [
                BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    spreadRadius: 1,
                    blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: FloatingNavbar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                selectedBackgroundColor:
                    Theme.of(context).colorScheme.onPrimary,
                unselectedItemColor: Theme.of(context).colorScheme.primary,
                selectedItemColor: Theme.of(context).colorScheme.secondary,
                showSelectedLabels: true,
                currentIndex: _selectedIndex,
                onTap: _selectedTab,
                showUnselectedLabels: true,
                elevation: 2,
                // borderRadius: 5,
                // itemBorderRadius: 5,
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
              ),
            ),
          )),
    );
  }

  Future<void> checkForExpiredSession() async {
    final String value = await _tokenStorage.readPreviousSessionTime();
    if (value != null) {
      final int diff = DateTime.now().difference(DateTime.parse(value)).inDays;
      // print("diff" + diff.toString());
      if (diff >= 2) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Session Expired!'),
          backgroundColor: blackButton,
        ));
        _authService.signOut();
        // FirebaseAuthService().signOut();
        // await flutterSecureStorage.delete(key: 'SessionCreatedAt');
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    checkForExpiredSession();
    _tokenStorage.writeCurrentSessionTime();
  }

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
