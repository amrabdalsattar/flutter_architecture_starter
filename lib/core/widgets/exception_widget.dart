import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/app_sizer.dart';
import '../theming/app_text_styles.dart';

class ExceptionWidget extends StatelessWidget {
  final String text;
  final IconData iconData;
  const ExceptionWidget({
    super.key,
    required this.text,
    this.iconData = Icons.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        Icon(iconData, color: AppColors.primary, size: 10.fromHeight),
        Padding(
          padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.w),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.font14MediumBlack,
          ),
        ),
      ],
    );
  }
}
