import 'package:books_app/common/themes.dart';
import 'package:books_app/constants/colors.dart';
import 'package:books_app/providers/books.dart';
import 'package:books_app/providers/theme.dart';
import 'package:books_app/screens/home.dart';
import 'package:books_app/screens/initial_screen.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/utils/keys_storage.dart';
import 'package:books_app/utils/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await TokenStorage().loadAuthToken();
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(lightTheme),
        ),
        ChangeNotifierProvider<Books>(
          create: (_) => Books(),
        ),
        ChangeNotifierProvider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final dynamic myAppUser = FirebaseAuthService().currentUserFromFireBase;
    return Listener(
        onPointerUp: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
      child: MaterialApp(
        theme: Provider.of<ThemeNotifier>(context).getTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Explr',
        home: Wrapper(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService firebaseAuthService =
        Provider.of<FirebaseAuthService>(context);
    return StreamBuilder<User>(
        stream: firebaseAuthService.onAuthStateChanged,
        builder: (_, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            return user == null ? InitialScreen() : Home();
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: blackButton,
            ));
          }
        });
  }
}
