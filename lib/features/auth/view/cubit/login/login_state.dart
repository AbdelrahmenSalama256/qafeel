abstract class LoginState {
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}

class LoginOtpSent extends LoginState {}

class LoginOtpVerifying extends LoginState {}

class LoginOtpVerified extends LoginState {}
