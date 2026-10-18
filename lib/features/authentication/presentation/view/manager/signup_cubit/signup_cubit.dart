import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_testing_app/core/error/failure.dart';
import 'package:my_testing_app/features/authentication/data/models/user_model.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/signup_cubit/signup_state.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';

class SignupCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignupCubit({required this.authRepository}) : super(InitialSignUp());
  Future<bool> signup(UserModel usermodel) async {
    emit(LoadingSignUp());
    bool success = await authRepository.signup(usermodel);
    if (success) {
      emit(SuccessSignUp());
      return true;
    } else {
      emit(ErrorSignUp(const Failure("Email already exists")));
      return false;
    }
  }
}
