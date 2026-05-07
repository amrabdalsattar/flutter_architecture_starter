part of '../locale_keys.dart';

class _ValidationLocale {
  const _ValidationLocale();

  String get emailInvalid => 'validation.emailInvalid'.tr();

  String get emailRequired => 'validation.emailRequired'.tr();

  String fieldMaxLength(String fieldName, String maxLength) =>
      'validation.fieldMaxLength'.tr(
        namedArgs: {'fieldName': fieldName, 'maxLength': maxLength},
      );

  String fieldRequired(String fieldName) =>
      'validation.fieldRequired'.tr(namedArgs: {'fieldName': fieldName});

  String get fullNameMaxLength => 'validation.fullNameMaxLength'.tr();

  String get fullNameMinLength => 'validation.fullNameMinLength'.tr();

  String get fullNameRequired => 'validation.fullNameRequired'.tr();

  String get numberRequired => 'validation.numberRequired'.tr();

  String get onlyNumbers => 'validation.onlyNumbers'.tr();

  String get phoneLength => 'validation.phoneLength'.tr();

  String get phoneOnlyNumbers => 'validation.phoneOnlyNumbers'.tr();

  String get phoneRequired => 'validation.phoneRequired'.tr();
}
