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
    if (value.trim().length > 50) {
      return LocaleKeys.validation.fullNameMaxLength;
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
