import 'package:flutter/widgets.dart';

import 'error_state.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T>
    with ErrorState<T> {}
