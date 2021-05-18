import 'package:books_app/states/error_state.dart';
import 'package:flutter/widgets.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T> with ErrorState<T> {}
