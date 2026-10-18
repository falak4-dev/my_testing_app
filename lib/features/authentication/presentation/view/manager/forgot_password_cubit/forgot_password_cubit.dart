import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_testing_app/core/error/failure.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/forgot_password_cubit/forgot_password_state.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;
  ForgotPasswordCubit({required this.authRepository})
    : super(InitialForgotPassword());
  Future<void> sendOtp(String email) async {
    emit(LoadingForgotPassword());

    final otp = await authRepository.sendOtp(email);

    if (otp != null) {
      emit(SuccessForgotPassword(otp));
    } else {
      emit(ErrorForgotPassword(const Failure("Email not found")));
    }
  }
}
