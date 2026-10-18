import 'package:flutter/material.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';
import 'package:my_testing_app/features/authentication/repostryImplementation/auth_repositry_implementation.dart';
import 'core/router/app_router.dart';
import 'features/authentication/data/mock_auth_api.dart';

void main() {
  final mockAuthApi = MockAuthApi();

  final authRepository = AuthRepositryImplementation(mockAuthApi: mockAuthApi);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: createAppRouter(authRepository),
      debugShowCheckedModeBanner: false,
    );
  }
}
