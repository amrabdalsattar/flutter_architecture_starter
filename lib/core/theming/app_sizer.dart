import 'dart:math';

import 'package:flutter/material.dart';

class AppSizer {
  // Base design canvas size (mobile-first)
  static const _defaultSize = Size(390, 844);

  // Breakpoints
  static const double _mobileMaxWidth = 599;
  static const double _tabletMaxWidth = 1024;

  final BuildContext _context;

  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleText;
  static late double _scaleW;
  static late double _scaleH;

  static late bool isMobile;
  static late bool isTablet;
  static late bool isDesktop;

  static late EdgeInsets padding;

  static double get shortestSide => min(_screenWidth, _screenHeight);
  static double get longestSide => max(_screenWidth, _screenHeight);
  static double get aspectRatio => _screenHeight / _screenWidth;

  AppSizer.initialize(this._context) {
    final mq = MediaQuery.of(_context);
    _screenWidth = mq.size.width;
    _screenHeight = mq.size.height;
    padding = mq.padding;

    isMobile = _screenWidth <= _mobileMaxWidth;
    isTablet =
        _screenWidth > _mobileMaxWidth && _screenWidth <= _tabletMaxWidth;
    isDesktop = _screenWidth > _tabletMaxWidth;

    _scaleW = _screenWidth / _defaultSize.width;
    _scaleH = _screenHeight / _defaultSize.height;

    _scaleText = _screenWidth / _defaultSize.width;
    if (isTablet) _scaleText /= 1.4;
    if (isDesktop) _scaleText /= 1.9;
  }

  static Future<void> ensureScreenSize() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();

    await Future.doWhile(() {
      final window = binding.platformDispatcher.implicitView;

      if (window == null || window.physicalSize.isEmpty) {
        return Future.delayed(const Duration(milliseconds: 10), () => true);
      }

      return false;
    });

    binding.allowFirstFrame();
  }

  /// Returns a value based on the current device type.
  static T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}

extension Responsive on num {
  /// Scales relative to design width (390px baseline).
  double get w => this * AppSizer._scaleW;

  /// Scales relative to design height (844px baseline).
  double get h => this * AppSizer._scaleH;

  /// Percentage of actual screen width.
  double get fromWidth => this / 100 * AppSizer._screenWidth;

  /// Percentage of actual screen height.
  double get fromHeight => this / 100 * AppSizer._screenHeight;

  /// Scales font size, dampened on tablets and desktops.
  double get sp => this * AppSizer._scaleText;

  /// Scales using the shorter axis — ideal for radii, icons, padding.
  double get r {
    final scale = min(AppSizer._scaleW, AppSizer._scaleH);
    return this * scale;
  }
}
