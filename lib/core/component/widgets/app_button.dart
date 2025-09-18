import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';

enum AppButtonType { primary, secondary, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final Gradient? gradient; // ✅ جديد

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = 60,
    this.width,
    this.padding,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.gradient, // ✅ جديد
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    switch (type) {
      case AppButtonType.primary:
        return _buildPrimary(context, isDisabled);
      case AppButtonType.secondary:
        return _buildSecondary(context, isDisabled);
      case AppButtonType.text:
        return _buildText(context, isDisabled);
    }
  }

  Widget _buildPrimary(BuildContext context, bool isDisabled) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width?.w,
      height: height.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.appGradientSimplified, // ✅
          color:
              gradient == null ? (backgroundColor ?? AppColors.primary) : null,
          borderRadius: borderRadius ?? BorderRadius.circular(15.r),
        ),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(15.r),
            ),
          ),
          child: _buildContent(Colors.white),
        ),
      ),
    );
  }

  Widget _buildSecondary(BuildContext context, bool isDisabled) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width?.w,
      height: height.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius ?? BorderRadius.circular(15.r),
          color: gradient == null ? (backgroundColor ?? Colors.white) : null,
          border: Border.all(
            color: isDisabled ? Colors.grey : borderColor ?? AppColors.primary,
          ),
        ),
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.primary,
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(15.r),
            ),
          ),
          child: _buildContent(AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, bool isDisabled) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width?.w,
      height: height.h,
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: AppColors.primary,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(20.r),
          ),
        ),
        child: _buildContent(AppColors.primary),
      ),
    );
  }

  Widget _buildContent(Color textColor) {
    if (isLoading) {
      return SizedBox(
        height: 24.h,
        width: 24.w,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[prefixIcon!, SizedBox(width: 8.w)],
        Text(
          text,
          style: textStyle ??
              TextStyle(
                color: textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
        ),
        if (suffixIcon != null) ...[SizedBox(width: 8.w), suffixIcon!],
      ],
    );
  }
}
