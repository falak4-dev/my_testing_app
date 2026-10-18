import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_testing_app/core/error/failure.dart';
import 'package:my_testing_app/features/authentication/data/models/user_model.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/login_cubit/login_state.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(InitialLogin());
  Future<UserModel?> login(UserModel usermodel, bool remember) async {
    emit(LoadingLogin());

    final user = await authRepository.login(usermodel);
    if (user != null) {
      if (remember) {
        await saveRememberedEmail(usermodel.email);
      } else {
        await deleteRememberedEmail();
      }

      emit(SuccessLogin(user));
      return user;
    } else {
      emit(ErrorLogin(const Failure("Invalid email or password")));
      return null;
    }
  }

  Future<String?> getRememberedEmail() async {
    return authRepository.getRememberedEmail();
  }

  Future<void> saveRememberedEmail(String email) async {
    await authRepository.saveRememberedEmail(email);
  }

  Future<void> deleteRememberedEmail() async {
    await authRepository.deleteRememberedEmail();
  }
}
