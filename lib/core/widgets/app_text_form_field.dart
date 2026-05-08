import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/app_input_decoration.dart';
import '../theming/app_text_styles.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final String? initialValue;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String? text) validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool disable;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextDirection? textDirection;
  final Widget? prefixIcon;
  final double? borderRadiusValue;
  final Color? enabledBorderColor;
  final Color? fillColor;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onTap;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final Color? textColor;
  final Color? cursorColor;
  final int? maxLength;
  const AppTextFormField({
    super.key,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.controller,
    required this.validator,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.disable = false,
    this.textAlign,
    this.initialValue,
    this.contentPadding,
    this.autovalidateMode,
    this.focusNode,
    this.autofocus,
    this.textDirection,
    this.prefixIcon,
    this.borderRadiusValue,
    this.enabledBorderColor,
    this.fillColor,
    this.onTapOutside,
    this.onTap,
    this.minLines,
    this.maxLines,
    this.borderColor,
    this.textColor,
    this.cursorColor,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      autofocus: autofocus ?? false,
      initialValue: initialValue,
      readOnly: disable,
      onTap: onTap,
      maxLength: maxLength,

      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      cursorColor: cursorColor,

      textDirection: textDirection,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onTapOutside:
          onTapOutside ?? (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: AppInputDecoration.getDecoration(
        hintText: hintText,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        borderRadiusValue: borderRadiusValue,
        contentPadding: contentPadding,
        enabledBorderColor: enabledBorderColor,
        borderColor: borderColor,
      ),

      obscureText: isObscureText ?? false,
      style: AppTextStyles.font14RegularBlack.copyWith(
        color: textColor ?? AppColors.black,
      ),
      validator: validator,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.bottom,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
    );
  }
}
