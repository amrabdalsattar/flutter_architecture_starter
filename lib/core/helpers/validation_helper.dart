import 'localization/locale_keys.dart';
import 'regex_helper.dart';

abstract class ValidationHelper {
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation.fullNameRequired;
    }

    if (value.trim().length < 2) {
      return LocaleKeys.validation.fullNameMinLength;
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation.emailRequired;
    }

    if (!RegexHelper.email.hasMatch(value.trim())) {
      return LocaleKeys.validation.emailInvalid;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation.passwordRequired;
    }

    if (value.length < 8) {
      return LocaleKeys.validation.passwordMinLength;
    }

    if (!RegexHelper.uppercase.hasMatch(value)) {
      return LocaleKeys.validation.passwordNoUppercase;
    }

    if (!RegexHelper.lowercase.hasMatch(value)) {
      return LocaleKeys.validation.passwordNoLowercase;
    }

    if (!RegexHelper.number.hasMatch(value)) {
      return LocaleKeys.validation.passwordNoNumber;
    }

    if (!RegexHelper.passwordSpecialChar.hasMatch(value)) {
      return LocaleKeys.validation.passwordNoSpecialChar;
    }

    return null;
  }

  static String? validateRequired(
    String? value,
    String fieldName, {
    int? maxLength,
  }) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation.fieldRequired(fieldName);
    }

    if (maxLength != null && value.trim().length > maxLength) {
      return LocaleKeys.validation.fieldMaxLength(
        fieldName,
        maxLength.toString(),
      );
    }

    return null;
  }
}
