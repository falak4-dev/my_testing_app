import 'dart:math';
import 'package:my_testing_app/features/authentication/data/models/user_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MockAuthApi {
  static const String usersKey = 'users';
  final List<UserModel> users = [];
  String? otp;
  String? otpEmail;
  String? verifiedEmail;
  Future<void> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final savedUsers = prefs.getString(usersKey);

    if (savedUsers != null) {
      final List<dynamic> decodedUsers = jsonDecode(savedUsers);

      users.clear();

      users.addAll(decodedUsers.map((user) => UserModel.fromJson(user)));
    }
  }

  Future<void> saveUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final encodedUsers = jsonEncode(
      users.map((user) => user.toJson()).toList(),
    );

    await prefs.setString(usersKey, encodedUsers);
  }

  Future<bool> signup(UserModel usermodel) async {
    await Future.delayed(const Duration(seconds: 2));

    await loadUsers();

    if (users.any((user) => user.email == usermodel.email)) {
      return false;
    } else {
      users.add(usermodel);
      await saveUsers();
      return true;
    }
  }

  Future<UserModel?> login(UserModel usermodel) async {
    await Future.delayed(const Duration(seconds: 2));
    await loadUsers();
    UserModel? foundUser;
    for (final user in users) {
      if (user.email == usermodel.email &&
          user.password == usermodel.password) {
        foundUser = user;
        break;
      }
    }

    if (foundUser != null) {
      return foundUser;
    } else {
      return null;
    }
  }

  Future<String?> sendOtp(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    await loadUsers();
    print('Users: ${users.map((user) => user.email).toList()}');

    if (users.any((user) => user.email == email)) {
      otp = (Random().nextInt(9000) + 1000).toString();
      otpEmail = email;

      return otp;
    }

    return null;
  }

  Future<bool> verifyOtp(String enteredOtp) async {
    await Future.delayed(const Duration(seconds: 2));

    if (otpEmail != null && enteredOtp == otp) {
      verifiedEmail = otpEmail;
      otp = null;
      otpEmail = null;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPassword(String newPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    await loadUsers();
    bool updated = false;
    if (verifiedEmail != null) {
      for (int i = 0; i < users.length; i++) {
        if (users[i].email == verifiedEmail) {
          final updatedUser = users[i].copyWith(password: newPassword);
          users[i] = updatedUser;
          await saveUsers();
          verifiedEmail = null;
          updated = true;
          break;
        }
      }
      return updated;
    } else {
      return false;
    }
  }

  Future<void> saveRememberedEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('remembered_email', email);
  }

  Future<String?> getRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('remembered_email');
  }

  Future<void> deleteRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remembered_email');
  }
}
