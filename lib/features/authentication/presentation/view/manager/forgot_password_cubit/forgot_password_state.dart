import 'package:my_testing_app/core/error/failure.dart';

class ForgotPasswordState {}

class InitialForgotPassword extends ForgotPasswordState {}

class LoadingForgotPassword extends ForgotPasswordState {}

class SuccessForgotPassword extends ForgotPasswordState {
  final String otp;
  SuccessForgotPassword(this.otp);
}

class ErrorForgotPassword extends ForgotPasswordState {
  final Failure failure;
  ErrorForgotPassword(this.failure);
}
