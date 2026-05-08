class RegexHelper {
  static final onlyNumbers = RegExp(r'^\d+$');
  static final email = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  static final RegExp password = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );
  static final RegExp passwordSpecialChar = RegExp(r'[@$!%*?&]');
  static final RegExp uppercase = RegExp(r'[A-Z]');
  static final RegExp lowercase = RegExp(r'[a-z]');
  static final RegExp number = RegExp(r'\d');
}
