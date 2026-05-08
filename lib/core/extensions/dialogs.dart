import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/localization/locale_keys.dart';
import '../theming/app_colors.dart';
import '../theming/app_sizer.dart';
import '../theming/app_text_styles.dart';
import '../widgets/api_bloc_widgets/api_cubit.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/loading_alert_dialog.dart';
import 'navigations.dart';

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
