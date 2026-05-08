import 'dart:math';

import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/app_sizer.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final bool isChosen;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool withShadow;
  final Color? cardColor;
  final double? height;
  final double? width;
  final double blurRadius;
  final BoxBorder? border;
  const AppCard({
    super.key,
    required this.child,
    this.isChosen = false,
    this.margin,
    this.padding,
    this.withShadow = true,
    this.cardColor,
    this.height,
    this.width,
    this.blurRadius = 24,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? min(500, 100.fromWidth),
      margin: margin ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isChosen ? AppColors.offWhite : cardColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: border,
        boxShadow: withShadow
            ? [
                BoxShadow(
                  blurRadius: blurRadius,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                  color: AppColors.black.withValues(alpha: .08),
                ),
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                  color: AppColors.black.withValues(alpha: .08),
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
