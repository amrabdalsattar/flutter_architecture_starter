import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizer.dart';

abstract class FontWeightHelper {
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const black = FontWeight.w900;
}

TextStyle appTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? height,
}) {
  return TextStyle(
    height: height,
    fontStyle: fontStyle,
    decoration: decoration,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    fontSize: fontSize != null ? fontSize.sp : 16.sp,
    letterSpacing: letterSpacing,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    color: color,
  );
}

class AppTextStyles {
  static final font12RegularBlack = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.regular,
  );

  static final font13RegularBlack = appTextStyle(
    fontSize: 13.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.regular,
  );

  static final font20MediumBlack = appTextStyle(
    fontSize: 20.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.medium,
  );

  static final font20MediumDarkGray = appTextStyle(
    fontSize: 20.sp,
    color: AppColors.darkGray,
    fontWeight: FontWeightHelper.medium,
  );
  static final font24BoldBlack = appTextStyle(
    fontSize: 24.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.bold,
  );
  static final font24BoldWhite = appTextStyle(
    fontSize: 24.sp,
    color: AppColors.white,
    fontWeight: FontWeightHelper.bold,
  );

  static final font20SemiBoldBlack = appTextStyle(
    fontSize: 20.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.semiBold,
  );
  static final font20SemiBoldMain = appTextStyle(
    fontSize: 20.sp,
    color: AppColors.primary,
    fontWeight: FontWeightHelper.semiBold,
  );

  static final font12SemiBoldGray = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.blueGray,
    fontWeight: FontWeightHelper.semiBold,
  );

  static final font14SemiBoldBlack = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.semiBold,
  );

  static final font14BoldWhite = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.white,
    fontWeight: FontWeightHelper.bold,
  );
  static final font14RegularMain = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.primary,
    fontWeight: FontWeightHelper.regular,
  );
  static final font14BoldMain = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.primary,
    fontWeight: FontWeightHelper.bold,
  );

  static final font14MediumBlack = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.medium,
  );
  static final font14MediumWhite = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.white,
    fontWeight: FontWeightHelper.medium,
  );

  static final font16MediumWhite = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.white,
    fontWeight: FontWeightHelper.medium,
  );

  static final font12MediumRed = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.red,
    fontWeight: FontWeightHelper.medium,
  );

  static final font12MediumWhite = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.white,
    fontWeight: FontWeightHelper.medium,
  );

  static final font12RegularWhite = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.white,
    fontWeight: FontWeightHelper.regular,
  );

  static final font14RegularBlack = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.regular,
  );

  static final font32SemiBoldBlack = appTextStyle(
    fontSize: 32.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.semiBold,
  );

  static final font20BoldBlack = appTextStyle(
    fontSize: 20.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.bold,
  );

  static final font12RegularGray = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.blueGray,
    fontWeight: FontWeightHelper.regular,
  );
  static final font11RegularGray = appTextStyle(
    fontSize: 11.sp,
    color: AppColors.blueGray,
    fontWeight: FontWeightHelper.regular,
  );
  static final font12RegularDarkGray = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.darkGray,
    fontWeight: FontWeightHelper.regular,
  );

  static final font14RegularGray = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.blueGray,
    fontWeight: FontWeightHelper.regular,
  );

  static final font15RegularGray = appTextStyle(
    fontSize: 15.sp,
    color: AppColors.blueGray,
    fontWeight: FontWeightHelper.regular,
  );

  static final font18SemiBoldBlack = appTextStyle(
    fontSize: 18.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.semiBold,
  );

  static final font16MediumBlack = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.medium,
  );
  static final font16RegularBlack = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.regular,
  );

  static final font16RegularGray = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.darkGray,
    fontWeight: FontWeightHelper.regular,
  );

  static final font16RegularWhite = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.white,
    fontWeight: FontWeightHelper.regular,
  );

  static final font24SemiBoldBlack = appTextStyle(
    fontSize: 24.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.semiBold,
  );

  static final font16MediumMain = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.primary,
    fontWeight: FontWeightHelper.medium,
  );

  static final font12BoldMain = appTextStyle(
    fontSize: 12.sp,
    color: AppColors.primary,
    fontWeight: FontWeightHelper.bold,
  );

  static final font16MediumRed = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.red,
    fontWeight: FontWeightHelper.medium,
  );

  static final font16MediumGray = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.blueGray,
    fontWeight: FontWeightHelper.medium,
  );

  static final font10RegularGray = appTextStyle(
    fontSize: 10.sp,
    color: AppColors.blueGray,
    fontWeight: FontWeightHelper.regular,
  );

  static final font16SemiBoldBlack = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.semiBold,
  );
  static final font16SemiBoldMain = appTextStyle(
    fontSize: 16.sp,
    color: AppColors.primary,
    fontWeight: FontWeightHelper.semiBold,
  );

  static final font24BoldMain = appTextStyle(
    fontSize: 24.sp,
    color: AppColors.primary,
    fontWeight: FontWeightHelper.bold,
  );

  static final font11RegularDarkGray = appTextStyle(
    fontSize: 11.sp,
    color: AppColors.darkGray,
    fontWeight: FontWeightHelper.regular,
  );
  static final font14RegularDarkGray = appTextStyle(
    fontSize: 14.sp,
    color: AppColors.darkGray,
    fontWeight: FontWeightHelper.regular,
  );
  static final font15RegularDarkGray = appTextStyle(
    fontSize: 15.sp,
    color: AppColors.darkGray,
    fontWeight: FontWeightHelper.regular,
  );
  static final font15MediumBlack = appTextStyle(
    fontSize: 15.sp,
    color: AppColors.black,
    fontWeight: FontWeightHelper.medium,
  );
}
