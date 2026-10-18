import 'package:my_testing_app/features/authentication/data/mock_auth_api.dart';
import 'package:my_testing_app/features/authentication/data/models/user_model.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';

class AuthRepositryImplementation implements AuthRepository {
  final MockAuthApi mockAuthApi;
  AuthRepositryImplementation({required this.mockAuthApi});
  @override
  Future<UserModel?> login(UserModel usermodel) async {
    return mockAuthApi.login(usermodel);
  }

  @override
  Future<bool> resetPassword(String newPassword) async {
    return mockAuthApi.resetPassword(newPassword);
  }

  @override
  Future<String?> sendOtp(String email) async {
    return mockAuthApi.sendOtp(email);
  }

  @override
  Future<bool> signup(UserModel usermodel) async {
    return mockAuthApi.signup(usermodel);
  }

  @override
  Future<bool> verifyOtp(String enteredOtp) async {
    return mockAuthApi.verifyOtp(enteredOtp);
  }

  @override
  Future<void> saveRememberedEmail(String email) async {
    await mockAuthApi.saveRememberedEmail(email);
  }

  @override
  Future<String?> getRememberedEmail() async {
    return mockAuthApi.getRememberedEmail();
  }

  @override
  Future<void> deleteRememberedEmail() async {
    await mockAuthApi.deleteRememberedEmail();
  }
}
