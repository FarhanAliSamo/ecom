import 'package:ecom/core/app_colors.dart';
import 'package:ecom/core/app_constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 8,
    this.backgroundColor,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final Color defaultTextColor = brightness == Brightness.dark
        ? AppColors.darkHeadingText
        : AppColors.white;
    final TextStyle defaultTextStyle = TextStyle(
      color: defaultTextColor,
      fontWeight: FontWeight.w600,
      fontSize: AppConstants.large,
      fontFamily: AppConstants.fontPoppins,
    );
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: textStyle ?? defaultTextStyle,
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
