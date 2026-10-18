import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_testing_app/features/authentication/data/models/user_model.dart';
import 'package:my_testing_app/features/authentication/presentation/view/forgot_password_view.dart';
import 'package:my_testing_app/features/authentication/presentation/view/home_view.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/login_cubit/login_cubit.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/signup_cubit/signup_cubit.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:my_testing_app/features/authentication/repositry/auth_repository.dart';
import 'package:my_testing_app/features/authentication/presentation/view/reset_password_view.dart';
import 'package:my_testing_app/features/authentication/presentation/view/signup_view.dart';
import 'package:my_testing_app/features/authentication/presentation/view/verify_otp_view.dart';
import '../../features/authentication/presentation/view/login_view.dart';

GoRouter createAppRouter(AuthRepository authRepository) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => LoginCubit(authRepository: authRepository),
            child: const LoginView(),
          );
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => SignupCubit(authRepository: authRepository),
            child: const SignUpView(),
          );
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          final user = state.extra as UserModel;

          return HomeView(user: user);
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => ForgotPasswordCubit(authRepository: authRepository),
            child: const ForgotPasswordView(),
          );
        },
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) => BlocProvider(
          create: (_) => VerifyOtpCubit(authRepository: authRepository),
          child: const VerifyOtpView(),
        ),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => ResetPasswordCubit(authRepository: authRepository),
            child: const ResetPasswordView(),
          );
        },
      ),
    ],
  );
}
