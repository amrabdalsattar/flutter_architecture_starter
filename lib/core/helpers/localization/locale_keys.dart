import 'package:easy_localization/easy_localization.dart';

part 'topics/validation_locale.dart';
part 'topics/errors_locale.dart';
part 'topics/common_locale.dart';
part 'topics/account_locale.dart';

abstract class LocaleKeys {
  static const common = _CommonLocale();
  static const validation = _ValidationLocale();
  static const errors = _ErrorsLocale();
  static const account = _AccountLocale();
}
