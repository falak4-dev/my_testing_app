import 'package:my_testing_app/core/error/failure.dart';

class ResetPasswordState {}

class InitialResetPassword extends ResetPasswordState {}

class LoadingResetPassword extends ResetPasswordState {}

class SuccessResetPassword extends ResetPasswordState {}

class ErrorResetPassword extends ResetPasswordState {
  final Failure failure;
  ErrorResetPassword(this.failure);
}
