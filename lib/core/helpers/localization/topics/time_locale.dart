part of '../locale_keys.dart';

class _TimeLocale {
  const _TimeLocale();

  String get day => 'time.day'.tr();

  String get days => 'time.days'.tr();

  String get hour => 'time.hour'.tr();

  String get hours => 'time.hours'.tr();

  String get lessThanOneSecond => 'time.lessThanOneSecond'.tr();

  String get minute => 'time.minute'.tr();

  String get minutes => 'time.minutes'.tr();

  String get month => 'time.month'.tr();

  String get months => 'time.months'.tr();

  String get orMore => 'time.orMore'.tr();

  String get second => 'time.second'.tr();

  String get seconds => 'time.seconds'.tr();

  String since(String name) =>
      'time.since'.tr(
          namedArgs: {'name': name});

  String sinceWithValue(String value, String name) =>
      'time.sinceWithValue'.tr(
          namedArgs: {'value': value, 'name': name});

  String get twoDays => 'time.twoDays'.tr();

  String get twoHours => 'time.twoHours'.tr();

  String get twoMinutes => 'time.twoMinutes'.tr();

  String get twoMonths => 'time.twoMonths'.tr();

  String get twoSeconds => 'time.twoSeconds'.tr();

  String get twoWeeks => 'time.twoWeeks'.tr();

  String get twoYears => 'time.twoYears'.tr();

  String get week => 'time.week'.tr();

  String get weeks => 'time.weeks'.tr();

  String get year => 'time.year'.tr();

  String get years => 'time.years'.tr();
}
