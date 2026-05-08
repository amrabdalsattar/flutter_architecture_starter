import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/app_text_styles.dart';

extension SnackBarHelper on BuildContext {
  static const _duration = Duration(seconds: 2);
  static const _behavior = SnackBarBehavior.floating;
  static final _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );

  void showSuccessSnackBar({required String content}) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: AppTextStyles.font16MediumWhite,
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.primary,
      behavior: _behavior,
      duration: _duration,
      shape: _shape,
    );
    _showSnackBar(snackBar);
  }

  void showErrorSnackBar({required String content}) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: AppTextStyles.font16MediumWhite,
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.red,
      behavior: _behavior,
      duration: _duration,
      shape: _shape,
    );
    _showSnackBar(snackBar);
  }

  void _showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension FlushBarHelper on BuildContext {
  void showFlushBar({
    required String content,
    Color? color,
    FlushbarPosition? position,
  }) {
    Flushbar(
      messageText: Text(content, style: AppTextStyles.font14MediumWhite),
      backgroundColor: color ?? AppColors.red,
      flushbarPosition: position ?? FlushbarPosition.BOTTOM,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      animationDuration: const Duration(milliseconds: 600),
      duration: const Duration(seconds: 3),
    ).show(this);
  }
}
