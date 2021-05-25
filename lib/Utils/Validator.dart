import '../Constants/regex.dart';

class Validator {
  static String confirmationCode(String confirmationCode) {
    if (confirmationCode.isEmpty || confirmationCode.length != 6) {
      return 'Confirmation code must be 6 characters long';
    }

    return null;
  }

  static String email(String email) {
    if (email.isEmpty || email.length < 5) {
      return 'Email must be at least 5 characters long';
    }

    if (!RegExp(EMAIL_REGEX).hasMatch(email)) {
      return 'Email must be in the right format';
    }

    return null;
  }

  static String password(String password) {
    if (password.isEmpty || password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }
}
