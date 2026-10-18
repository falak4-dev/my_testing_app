import 'package:my_testing_app/features/authentication/data/models/user_model.dart';

abstract class AuthRepository {
  Future<bool> signup(UserModel usermodel);
  Future<UserModel?> login(UserModel usermodel);
  Future<String?> sendOtp(String email);
  Future<bool> verifyOtp(String enteredOtp);
  Future<bool> resetPassword(String newPassword);
  Future<void> saveRememberedEmail(String email);
  Future<String?> getRememberedEmail();
  Future<void> deleteRememberedEmail();
}
