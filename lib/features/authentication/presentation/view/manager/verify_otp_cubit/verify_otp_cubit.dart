import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_testing_app/core/error/failure.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/verify_otp_cubit/verify_otp_state.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final AuthRepository authRepository;
  VerifyOtpCubit({required this.authRepository}) : super(InitialVerifyOtp());
  Future<bool> verifyOtp(String enteredOtp) async {
    emit(LoadingVerifyOtp());
    bool isOtpVerified = await authRepository.verifyOtp(enteredOtp);
    if (isOtpVerified) {
      emit(SuccessVerifyOtp());
      return true;
    } else {
      emit(ErrorVerifyOtp(const Failure("Invalid OTP")));
      return false;
    }
  }
}
