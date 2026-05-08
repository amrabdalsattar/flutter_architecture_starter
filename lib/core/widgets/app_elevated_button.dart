import 'dart:math';

import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/app_sizer.dart';
import '../theming/app_text_styles.dart';
import 'custom_inkwell.dart';

class AppElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Function()? onPressed;
  final bool Function()? isActive;
  final String text;
  final double? borderRadius;
  final Gradient? gradient;
  final Widget? suffixIcon;
  const AppElevatedButton({
    super.key,
    this.width,
    this.height,
    this.color,
    this.isActive,
    required this.text,
    this.onPressed,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.gradient,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final deActivated = isActive != null && !isActive!();
    return CustomInkWell(
      onTap: deActivated ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width ?? (min(100.fromWidth, 500)),
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          color:
              deActivated
                  ? (color ?? AppColors.primary).withValues(alpha: .4)
                  : (color ?? AppColors.primary),
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          border: Border.all(
            color:
                deActivated
                    ? (borderColor ?? AppColors.primary).withValues(alpha: .4)
                    : (borderColor ?? AppColors.primary),
          ),
        ),

        padding: EdgeInsets.symmetric(
          vertical: height != null ? height! / 8 : 14.h,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyles.font14SemiBoldBlack.copyWith(
                color: textColor ?? AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            if (suffixIcon != null) ...[SizedBox(width: 4.w), suffixIcon!],
          ],
        ),
      ),
    );
  }
}
