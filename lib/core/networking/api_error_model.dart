import '../helpers/localization/locale_keys.dart';

class ApiErrorModel {
  final String message;
  final int? code;

  const ApiErrorModel({required this.message, this.code});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message:
          json['errorMessage'] as String? ?? LocaleKeys.errors.unknownError,
      code: json['code'],
    );
  }
}
