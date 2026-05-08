import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theming/app_colors.dart';
import '../theming/app_text_styles.dart';
import '../utils/extensions.dart';
import 'app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// This can String or Widget
  final dynamic title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? toolbarHeight;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool showLeading;
  final double? leadingWidth;
  const CustomAppBar({
    super.key,
    this.title = '',
    this.onBackPressed,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.systemOverlayStyle,
    this.toolbarHeight,
    this.showLeading = true,
    this.leadingWidth,
  }) : assert(
         title is String || title is Widget,
         'Title must be a String or Widget',
       );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      elevation: elevation ?? 0,
      surfaceTintColor: AppColors.transparent,
      toolbarHeight: toolbarHeight,
      leading: _buildLeading(context),
      leadingWidth: showLeading ? leadingWidth : 0,
      title:
          title is Widget
              ? title
              : AppText(
                title,
                style: AppTextStyles.font16MediumBlack.copyWith(
                  color: foregroundColor ?? AppColors.black,
                ),
              ),
      centerTitle: centerTitle,
      actions: actions,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget? _buildLeading(BuildContext context) {
    if (showLeading) {
      return context.canPop()
          ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: foregroundColor ?? AppColors.black,
              size: 18,
            ),
            onPressed: onBackPressed ?? () => context.pop(),
          )
          : null;
    }

    return const SizedBox.shrink();
  }
}
