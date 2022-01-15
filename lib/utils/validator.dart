class Validator {
  String dummy = '';
  static const String EMAIL_REGEX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static const String PHONE_REGEX = 
    r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';;

  static String? confirmationCode(String confirmationCode) {
    if (confirmationCode.isEmpty || confirmationCode.length != 6) {
      return 'Confirmation code must be 6 characters long';
    }

    return null;
  }

  static String? email(String? email) {
    if (email == null) return 'Email cannot be empty';
    if (email.length < 5) {
      return 'Email must be at least 5 characters long';
    }

    if (!RegExp(EMAIL_REGEX).hasMatch(email)) {
      return 'Email must be in the right format';
    }

    return null;
  }

  static String? password(String? password) {
    if (password == null) return 'Password cannot be empty';
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  static String? username(String? uname) {
    if (uname == null) {
      return 'Username cannot be null';
    }

    return null;
  }

  static String? phone(String? phone) {
    if (phone == null) return 'Phone number cannot be empty';
    if (phone.length != 10) {
      return 'Phone number must be 10 digit number';
    }
    if (!RegExp(PHONE_REGEX).hasMatch(phone)) {
      return 'Phone number must be in the right format';
    }
    return null;
  }
}
