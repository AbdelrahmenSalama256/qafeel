import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void submitRegister() async {
    emit(RegisterLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        phone.text.isNotEmpty) {
      emit(RegisterOtpSent());
    } else {
      emit(RegisterFailure('Please fill required fields'));
    }
  }

  void verifyOtp() async {
    emit(RegisterOtpVerifying());
    await Future.delayed(const Duration(seconds: 1));
    emit(RegisterOtpVerified());
  }

  @override
  Future<void> close() {
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    return super.close();
  }
}
