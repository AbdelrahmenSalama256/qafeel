import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/component/custom_toast.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/component/widgets/app_text_field.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/constants/widgets/print_util.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/core/utils/validator.dart';
import 'package:qafeel/features/auth/view/cubit/login/login_state.dart';
import 'package:qafeel/features/auth/view/cubit/register/register_cubit.dart';
import 'package:qafeel/features/auth/view/cubit/register/register_state.dart';
import 'package:qafeel/features/auth/view/widgets/custom_scaffold.dart';
import 'package:qafeel/features/auth/view/widgets/otp_bottom_sheet.dart';

import '../../../core/constants/navigation.dart';
import '../../base/view/base_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            showToast(context,
                message: state.message, state: ToastStates.error);
          } else if (state is RegisterOtpSent) {
            _showOtpBottomSheet(context);
          } else if (state is RegisterSuccess) {
            showToast(context,
                message: 'registration_success'.tr(context),
                state: ToastStates.success);
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();
          return CustomScaffold(
            showLogo: true,
            logoPath: "assets/images/png/logo.png",
            curveRadius: 50.r,
            curveHeight: 200.h,
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              // padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "register_title".tr(context),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "register_subtitle".tr(context),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            enabled: state is LoginLoading ? false : true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15.h,
                              horizontal: 15.w,
                            ),
                            controller: cubit.firstName,
                            hintText: "first_name".tr(context),
                            validator: (v) =>
                                Validators.validateName(v, context),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: AppTextField(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15.h,
                              horizontal: 15.w,
                            ),
                            enabled: state is LoginLoading ? false : true,
                            controller: cubit.lastName,
                            hintText: "last_name".tr(context),
                            validator: (v) =>
                                Validators.validateName(v, context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: cubit.phone,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 15.w,
                      ),
                      enabled: state is LoginLoading ? false : true,
                      hintText: "phone_number".tr(context),
                      keyboardType: TextInputType.phone,
                      validator: (v) => Validators.validatePhone(v, context),
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: cubit.email,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 15.w,
                      ),
                      enabled: state is LoginLoading ? false : true,
                      hintText: "email".tr(context),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => Validators.validateEmail(v, context),
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.submitRegister();
                        }
                      },
                      text: "register_title".tr(context),
                      gradient: AppColors.longGradient,
                      isLoading: state is RegisterLoading,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOtpBottomSheet(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    final registerCubit = context.read<RegisterCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: registerCubit,
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (otpContext, state) {
            if (state is RegisterFailure) {
              showToast(otpContext,
                  message: state.message, state: ToastStates.error);
            } else if (state is RegisterOtpVerified) {
              showToast(otpContext,
                  message: 'registration_complete'.tr(otpContext),
                  state: ToastStates.success);
              Navigator.pop(context);
              navigateAndFinish(context, BaseScreen());
            }
          },
          builder: (otpContext, state) {
            return SafeArea(
              child: OtpBottomSheet(
                controller: otpController,
                onConfirm: (code) {
                  PrintUtil.debug('OTP Entered: $code');
                  otpContext.read<RegisterCubit>().verifyOtp();
                },
                isLoading: state is RegisterOtpVerifying,
              ),
            );
          },
        ),
      ),
    );
  }
}
