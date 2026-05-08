import 'package:intl/intl.dart';

import 'localization/locale_keys.dart';

class DateFormatHelper {
  const DateFormatHelper._();

  static String formatDate(DateTime date, {bool hasYear = true}) {
    final DateFormat dateFormat = hasYear
        ? DateFormat('d MMMM y', 'ar')
        : DateFormat('d MMMM', 'ar');
    return dateFormat.format(date);
  }

  static DateTime? parseDate(value) {
    if (value == null || value.toString().isEmpty) return null;
    return DateTime.parse(value.toString());
  }

  static String formatDurationFromNow(DateTime date) {
    final dateAsUtc = _getDateAsUtc(date);
    final duration = DateTime.now().toUtc().difference(dateAsUtc);

    for (var unit in _DateUnit.units) {
      if (unit.shouldBeUsed(duration)) {
        return unit.formattedString(duration);
      }
    }

    return LocaleKeys.time.lessThanOneSecond;
  }

  static DateTime _getDateAsUtc(DateTime date) {
    return date.toIso8601String().endsWith('Z')
        ? date
        : DateTime.parse('${date.toIso8601String()}Z');
  }

  static String getTime(DateTime dateTime, String? localeLanguage) {
    return DateFormat.jm(
      localeLanguage ?? 'ar',
    ).format(_getDateAsUtc(dateTime).toLocal());
  }
}

class _DateUnit {
  final String singularName;
  final String twinName;
  final String pluralName;
  final int Function(Duration duration) value;
  final bool Function(Duration duration) shouldBeUsed;

  const _DateUnit({
    required this.singularName,
    required this.twinName,
    required this.pluralName,
    required this.value,
    required this.shouldBeUsed,
  });

  String formattedString(Duration duration) {
    final int value = this.value(duration);

    if (value == 1) return LocaleKeys.time.since(singularName);
    if (value == 2) return LocaleKeys.time.since(twinName);

    if (value >= 3 && value <= 10) {
      return LocaleKeys.time.sinceWithValue(value.toString(), pluralName);
    }

    return LocaleKeys.time.sinceWithValue(value.toString(), singularName);
  }

  // order is important
  static List<_DateUnit> get units => [
    _DateUnit(
      singularName: LocaleKeys.time.year,
      twinName: LocaleKeys.time.twoYears,
      pluralName: LocaleKeys.time.years,
      value: (d) => d.inDays ~/ 365,
      shouldBeUsed: (d) => d.inDays >= 365,
    ),
    _DateUnit(
      singularName: LocaleKeys.time.month,
      twinName: LocaleKeys.time.twoMonths,
      pluralName: LocaleKeys.time.months,
      value: (d) => d.inDays ~/ 30,
      shouldBeUsed: (d) => d.inDays >= 30,
    ),
    _DateUnit(
      singularName: LocaleKeys.time.week,
      twinName: LocaleKeys.time.twoWeeks,
      pluralName: LocaleKeys.time.weeks,
      value: (d) => d.inDays ~/ 7,
      shouldBeUsed: (d) => d.inDays >= 7,
    ),
    _DateUnit(
      singularName: LocaleKeys.time.day,
      twinName: LocaleKeys.time.twoDays,
      pluralName: LocaleKeys.time.days,
      value: (d) => d.inDays,
      shouldBeUsed: (d) => d.inDays > 0,
    ),
    _DateUnit(
      singularName: LocaleKeys.time.hour,
      twinName: LocaleKeys.time.twoHours,
      pluralName: LocaleKeys.time.hours,
      value: (d) => d.inHours,
      shouldBeUsed: (d) => d.inHours > 0,
    ),
    _DateUnit(
      singularName: LocaleKeys.time.minute,
      twinName: LocaleKeys.time.twoMinutes,
      pluralName: LocaleKeys.time.minutes,
      value: (d) => d.inMinutes,
      shouldBeUsed: (d) => d.inMinutes > 0,
    ),
    _DateUnit(
      singularName: LocaleKeys.time.second,
      twinName: LocaleKeys.time.twoSeconds,
      pluralName: LocaleKeys.time.seconds,
      value: (d) => d.inSeconds,
      shouldBeUsed: (d) => d.inSeconds > 0,
    ),
  ];
}
