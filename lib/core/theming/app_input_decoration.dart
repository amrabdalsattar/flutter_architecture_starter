import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizer.dart';
import 'app_text_styles.dart';

class AppInputDecoration {
  static InputDecoration getDecoration({
    required String hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadiusValue,
    Color? enabledBorderColor,
    Color? fillColor,
    Color? borderColor,
  }) {
    return InputDecoration(
      isDense: true,
      prefixIcon: prefixIcon,
      contentPadding:
          contentPadding ??
          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      focusedBorder: _getOutlinedBorder(
        borderColor ?? AppColors.primary,
        borderRadiusValue: borderRadiusValue,
      ),
      enabledBorder: _getOutlinedBorder(
        enabledBorderColor ?? AppColors.blueGray,
        borderRadiusValue: borderRadiusValue,
      ),
      errorBorder: _getOutlinedBorder(
        AppColors.red,
        borderRadiusValue: borderRadiusValue,
      ),
      focusedErrorBorder: _getOutlinedBorder(
        AppColors.red,
        borderRadiusValue: borderRadiusValue,
      ),
      hintStyle: AppTextStyles.font14RegularGray,
      hintText: hintText,

      suffixIcon: suffixIcon,
      isCollapsed: true,
      suffixIconConstraints: BoxConstraints(
        minHeight: 2.fromHeight,
        maxHeight: 5.fromHeight,
      ),
      fillColor: fillColor ?? AppColors.white,
      filled: true,
      errorStyle: AppTextStyles.font12MediumRed,
    );
  }

  static InputBorder _getOutlinedBorder(
    Color color, {
    double? borderRadiusValue,
  }) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1),
    borderRadius: BorderRadius.circular(borderRadiusValue ?? 8),
  );
}
