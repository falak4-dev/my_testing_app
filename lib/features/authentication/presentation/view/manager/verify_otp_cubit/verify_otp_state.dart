import 'package:my_testing_app/core/error/failure.dart';

class VerifyOtpState {}

class InitialVerifyOtp extends VerifyOtpState {}

class LoadingVerifyOtp extends VerifyOtpState {}

class SuccessVerifyOtp extends VerifyOtpState {}

class ErrorVerifyOtp extends VerifyOtpState {
  final Failure failure;
  ErrorVerifyOtp(this.failure);
}
