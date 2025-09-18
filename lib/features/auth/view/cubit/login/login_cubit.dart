import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void submitLogin() async {
    emit(LoginLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (phoneController.text.isNotEmpty) {
        emit(LoginOtpSent());
      } else {
        emit(LoginFailure('Please enter a valid phone number'));
      }
    } catch (e) {
      emit(LoginFailure('Login failed. Please try again.'));
    }
  }

  void completeLogin() async {
    emit(LoginLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure('Login completion failed'));
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }

  void verifyOtp(String code) async {
    emit(LoginOtpVerifying());
    try {
      await Future.delayed(Duration(seconds: 1)); // Simulate API call
      emit(LoginOtpVerified());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
