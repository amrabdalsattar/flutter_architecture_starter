import 'package:flutter/material.dart';

import '../../../../../../../core/theming/app_colors.dart';
import '../../../../../../../core/theming/app_sizer.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 460.h,
      child: Center(
        child: SizedBox(
          width: 45.w,
          height: 45.w,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3.w,
          ),
        ),
      ),
    );
  }
}
