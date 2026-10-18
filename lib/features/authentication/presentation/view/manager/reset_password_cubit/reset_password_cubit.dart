import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_testing_app/core/error/failure.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/reset_password_cubit/reset_password_state.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository authRepository;
  ResetPasswordCubit({required this.authRepository})
    : super(InitialResetPassword());
  Future<bool> resetPassword(String newPassword) async {
    emit(LoadingResetPassword());
    bool isPasswordReset = await authRepository.resetPassword(newPassword);
    if (isPasswordReset) {
      emit(SuccessResetPassword());

      return true;
    } else {
      emit(ErrorResetPassword(const Failure("Failed to reset password")));
      return false;
    }
  }
}
