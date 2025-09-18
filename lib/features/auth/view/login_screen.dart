import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/component/custom_toast.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/component/widgets/app_text_field.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/constants/navigation.dart';
import 'package:qafeel/core/constants/widgets/print_util.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/core/utils/validator.dart';
import 'package:qafeel/features/auth/view/cubit/login/login_cubit.dart';
import 'package:qafeel/features/auth/view/cubit/login/login_state.dart';
import 'package:qafeel/features/auth/view/cubit/register/register_cubit.dart';
import 'package:qafeel/features/auth/view/register_screen.dart';
import 'package:qafeel/features/auth/view/widgets/custom_scaffold.dart';
import 'package:qafeel/features/auth/view/widgets/otp_bottom_sheet.dart';

import '../../base/view/base_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: CustomScaffold(
        showLogo: true,
        logoPath: "assets/images/png/logo.png",
        curveRadius: 50.r,
        curveHeight: 200.h,
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              showToast(context,
                  message: state.message, state: ToastStates.error);
            } else if (state is LoginSuccess) {
              showToast(context,
                  message: 'login_success'.tr(context),
                  state: ToastStates.success);
            } else if (state is LoginOtpSent) {
              _showOtpBottomSheet(context);
            }
          },
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();
            return SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "login_title".tr(context),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "login_subtitle".tr(context),
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey),
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: cubit.phoneController,
                      hintText: "phone_number".tr(context),
                      keyboardType: TextInputType.phone,
                      validator: (p0) => Validators.validatePhone(p0, context),
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.submitLogin();
                        }
                      },
                      text: "send_verification_code".tr(context),
                      gradient: AppColors.longGradient,
                      isLoading: state is LoginLoading,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "no_account".tr(context),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey),
                        ),
                        SizedBox(width: 5.w),
                        InkWell(
                          onTap: () {
                            navigateTo(context, RegisterScreen());
                          },
                          child: Text(
                            "register_now".tr(context),
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.green),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showOtpBottomSheet(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (otpContext, state) {
            if (state is LoginFailure) {
              showToast(otpContext,
                  message: state.message, state: ToastStates.error);
            } else if (state is LoginOtpVerified) {
              showToast(otpContext,
                  message: 'otp_verified'.tr(otpContext),
                  state: ToastStates.success);
              Navigator.pop(otpContext);
              navigateAndFinish(context, BaseScreen());
            }
          },
          builder: (otpContext, state) {
            return OtpBottomSheet(
              controller: otpController,
              onConfirm: (code) {
                PrintUtil.debug('OTP Entered: $code');
                otpContext.read<LoginCubit>().verifyOtp(code);
              },
              isLoading: state is LoginOtpVerifying,
            );
          },
        ),
      ),
    );
  }
}
