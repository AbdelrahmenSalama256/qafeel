import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qafeel/core/component/custom_toast.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/core/utils/validator.dart';

class OtpBottomSheet extends StatefulWidget {
  final void Function(String code) onConfirm;
  final TextEditingController controller;
  final bool isLoading;

  const OtpBottomSheet({
    super.key,
    required this.onConfirm,
    required this.controller,
    this.isLoading = false,
  });

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30.w,
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: const Color(0xffB3B3B3),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "enter_otp".tr(context),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "${"otp_sent_to".tr(context)} XXX-XXX-XXXX",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 20.h),
            PinCodeTextField(
              appContext: context,
              length: 4,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              hintStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10.r),
                fieldHeight: 50.h,
                fieldWidth: 50.w,
                borderWidth: 0,
                errorBorderWidth: 1.w,
                activeBorderWidth: 1.w,
                disabledBorderWidth: 1.w,
                inactiveBorderWidth: 1.w,
                selectedBorderWidth: 1.w,
                errorBorderColor: AppColors.red,
                activeColor: const Color(0xff666666).withOpacity(0.3),
                selectedColor: const Color(0xff666666).withOpacity(0.3),
                inactiveColor: const Color(0xff666666).withOpacity(0.3),
              ),
              onChanged: (v) {
                setState(() {
                  otp = v;
                });
              },
              controller: widget.controller,
              validator: (v) => Validators.validateOtp(v, context),
              autoDisposeControllers: false,
            ),
            SizedBox(height: 20.h),
            AppButton(
              text: 'verify_otp'.tr(context),
              gradient: AppColors.longGradient,
              onPressed: widget.isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        widget.onConfirm(otp);
                      }
                    },
              isLoading: widget.isLoading,
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: widget.isLoading
                  ? null
                  : () {
                      // context.read<RegisterCubit>().resendOtp();
                      showToast(context,
                          message: 'otp_resent'.tr(context),
                          state: ToastStates.info);
                    },
              child: Text(
                'resend_otp'.tr(context),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
