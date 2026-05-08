import 'dart:io';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../helpers/localization/locale_keys.dart';
import '../theming/app_colors.dart';
import '../theming/app_sizer.dart';
import '../theming/app_text_styles.dart';
import '../widgets/api_bloc_widgets/api_cubit.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/loading_alert_dialog.dart';

extension Navigation on BuildContext {
  Future<void> push({
    void Function(Object? result)? toExcuteAfterPop,
    required Widget widget,
    PageTransitionType type = PageTransitionType.fade,
  }) async {
    return Navigator.push(this, PageTransition(child: widget, type: type)).then(
      (value) {
        if (toExcuteAfterPop != null) toExcuteAfterPop(value);
      },
    );
  }

  void pushReplacementRightToLeftJoined({
    required Widget currentScreen,
    required Widget nextScreen,
  }) {
    Navigator.push(
      this,
      PageTransition(
        type: PageTransitionType.rightToLeftJoined,
        duration: const Duration(milliseconds: 500),
        childCurrent: currentScreen,
        child: nextScreen,
      ),
    );
  }

  void pushAndRemoveUntil({
    required Widget widget,
    PageTransitionType type = PageTransitionType.fade,
    bool Function(Route<dynamic>)? predicate,
  }) {
    Navigator.pushAndRemoveUntil(
      this,
      PageTransition(child: widget, type: type),
      predicate ?? (route) => false,
    );
  }

  void pushReplacement({
    required Widget widget,
    PageTransitionType type = PageTransitionType.fade,
    int transitionDurationInMillieSeconds = 200,
  }) {
    Navigator.pushReplacement(
      this,
      PageTransition(
        child: widget,
        type: type,
        duration: Duration(milliseconds: transitionDurationInMillieSeconds),
      ),
    );
  }

  void pop({Object? result}) {
    if (Navigator.canPop(this)) Navigator.pop(this, result);
  }

  bool canPop() => Navigator.canPop(this);
}

extension LoadingDialogExtension on BuildContext {
  void showLoadingAlertDialog({String? message}) {
    showDialog(
      context: this,
      builder: (_) => LoadingAlertDialog(message: message),
      barrierDismissible: false,
    );
  }

  void showProgressiveLoadingDialog<T extends Cubit<ApiState<L>>, L>(T cubit) {
    showDialog(
      context: this,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: ProgressiveLoadingDialog<T, L>(cubit: cubit),
      ),
      barrierDismissible: false,
    );
  }
}

extension RandomExtension<T> on Iterable<T> {
  T random() => elementAt(Random().nextInt(length));
}

extension IntExtension<T> on String {
  bool get isInt => int.tryParse(this) != null;
}

extension ToFixed on double {
  double toFixed(int fractionDigits) =>
      double.parse(toStringAsFixed(fractionDigits));
}

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
    showSnackBar(snackBar);
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
    showSnackBar(snackBar);
  }

  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension DialogHelper on BuildContext {
  void showAlertDialog({
    required String title,
    required String subTitle,
    String? denialText,
    String? confirmText,
    void Function()? onConfirm,
    void Function()? onCancel,
    bool barrierDismissible = true,
    Color? buttonColor,
  }) {
    showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(
        backgroundColor: AppColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTextStyles.font20SemiBoldBlack),
              SizedBox(height: 16.h),
              Text(
                subTitle,
                style: AppTextStyles.font12RegularBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      text: denialText ?? LocaleKeys.common.cancel,
                      height: 38.h,
                      onPressed: onCancel ?? () => pop(),
                      color: buttonColor ?? AppColors.red,
                      borderColor: buttonColor ?? AppColors.red,
                      borderRadius: 30,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppElevatedButton(
                      height: 38.h,
                      text: confirmText ?? LocaleKeys.common.confirm,
                      color: AppColors.white,
                      borderColor: buttonColor ?? AppColors.red,
                      textColor: buttonColor ?? AppColors.red,
                      borderRadius: 30,
                      onPressed: onConfirm ?? () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

extension ToIntString on num {
  String toIntStringIfPossible() {
    if (this == toInt()) return toInt().toString();

    return toString();
  }
}

extension BottomSheetExtension on BuildContext {
  Future<T?> showBottomSheet<T>({
    required Widget child,
    Color? backgroundColor,
    ShapeBorder? shape,
    Clip? clipBehavior,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: backgroundColor ?? Theme.of(this).canvasColor,
      shape:
          shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),

      clipBehavior: clipBehavior,
      builder: (_) => child,
    );
  }
}

extension ToMultipartFile on File {
  MultipartFile toMultipartFile() {
    return MultipartFile.fromFileSync(path);
  }
}

extension ToMultipartFiles on List<File> {
  List<MultipartFile> toMultipartFiles() {
    return map((file) => file.toMultipartFile()).toList();
  }
}
