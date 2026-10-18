import 'package:my_testing_app/core/error/failure.dart';
import 'package:my_testing_app/features/authentication/data/models/user_model.dart';

class LoginState {}

class InitialLogin extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {
  final UserModel usermodel;
  SuccessLogin(this.usermodel);
}

class ErrorLogin extends LoginState {
  final Failure failure;
  ErrorLogin(this.failure);
}
