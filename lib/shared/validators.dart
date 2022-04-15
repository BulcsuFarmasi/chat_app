class Validators {
  static bool required(String value) {
    return value == null || value.isEmpty;
  }

  static bool minLength(String value, int minLength) {
    return value != null && value.length < minLength;
  }

  static bool pattern(String value, RegExp pattern) {
    return value != null && !pattern.hasMatch(value);
  }

  static bool email(String value) {
    return pattern(value, RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));

  }
}