import 'package:my_testing_app/core/error/failure.dart';

class SignUpState {}

class InitialSignUp extends SignUpState {}

class LoadingSignUp extends SignUpState {}

class SuccessSignUp extends SignUpState {}

class ErrorSignUp extends SignUpState {
  final Failure failure;
  ErrorSignUp(this.failure);
}
