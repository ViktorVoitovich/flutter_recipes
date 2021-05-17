class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static bool isValidUserName(String name) {
    if (name.isEmpty || name.length < 3) {
      return false;
    }
    return true;
  }

  static bool isValidPassword(String password) {
    if (password.isEmpty || password.length < 4) {
      return false;
    }
    return true;
  }

  static bool isValidEmail(String email) {
    if (email.isEmpty || !_emailRegExp.hasMatch(email)) {
      return false;
    }
    return true;
  }
}
