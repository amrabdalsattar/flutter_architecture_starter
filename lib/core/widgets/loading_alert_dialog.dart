import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theming/app_colors.dart';
import '../theming/app_sizer.dart';
import '../theming/app_text_styles.dart';
import 'api_bloc_widgets/api_cubit.dart';

class ProgressiveLoadingDialog<T extends Cubit<ApiState<L>>, L>
    extends StatelessWidget {
  final T cubit;
  const ProgressiveLoadingDialog({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, ApiState<L>>(
      buildWhen: (_, current) => current is ApiLoadingState,
      builder: (context, state) {
        final String? message;

        if (state is ApiLoadingState) {
          message = (state as ApiLoadingState).message;
        } else {
          message = null;
        }

        return LoadingAlertDialog(message: message);
      },
    );
  }
}

class LoadingAlertDialog extends StatelessWidget {
  final String? message;
  const LoadingAlertDialog({super.key, this.message});

  Color get _backgroundColor {
    return message == null
        ? AppColors.transparent
        : AppColors.primary.withValues(alpha: 0.75);
  }

  double get _horizontalPadding {
    return message == null ? 120.w : 60.w;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: _backgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      alignment: Alignment.center,
      child: SizedBox(
        width: min(80.fromWidth, 400),
        child: message == null
            ? const _LoadingTile()
            : _LoadingTileWithText(message: message!),
      ),
    );
  }
}

class _LoadingTile extends StatelessWidget {
  const _LoadingTile();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: 30.w,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      ),
    );
  }
}

class _LoadingTileWithText extends StatelessWidget {
  final String message;
  const _LoadingTileWithText({required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
            width: 120.w,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.white),
            ),
          ),
          Container(
            height: 60.h,
            alignment: Alignment.center,
            child: Text(
              message,
              style: AppTextStyles.font16MediumWhite,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
