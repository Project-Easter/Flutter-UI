import 'package:books_app/states/ErrorState.dart';
import 'package:flutter/widgets.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T> with ErrorState<T> {}
