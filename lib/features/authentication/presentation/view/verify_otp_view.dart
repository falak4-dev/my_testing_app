import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:my_testing_app/features/authentication/presentation/view/manager/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:my_testing_app/features/authentication/presentation/view/manager/verify_otp_cubit/verify_otp_state.dart';
import 'package:my_testing_app/features/authentication/presentation/view/widgets/otp_input_field.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/widget/custom_button.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final _formKey = GlobalKey<FormState>();

  final otpControllers = List.generate(4, (_) => TextEditingController());

  final otpFocusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final extra = GoRouterState.of(context).extra;

      if (extra is Map<String, String>) {
        final otp = extra['otp'];

        if (otp != null) {
          _showOtpSnackBar(otp);
        }
      }
    });
  }

  void _showOtpSnackBar(String otp) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 15),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.25)),
        ),
        content: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_read_outlined,
                color: AppColors.primary,
                size: 23,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Verification Code',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Your OTP code is: $otp',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final focusNode in otpFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  String get enteredOtp {
    return otpControllers.map((controller) => controller.text).join();
  }

  void verifyOtp() {
    if (_formKey.currentState!.validate()) {
      context.read<VerifyOtpCubit>().verifyOtp(enteredOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        if (state is SuccessVerifyOtp) {
          context.push('/reset-password');
        }

        if (state is ErrorVerifyOtp) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              backgroundColor: Colors.white,
              elevation: 6,
              duration: const Duration(seconds: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.red.withValues(alpha: 0.25)),
              ),
              content: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      state.failure.message,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },

      builder: (context, state) {
        final isLoading = state is LoadingVerifyOtp;

        return Scaffold(
          backgroundColor: AppColors.background,

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: Form(
                key: _formKey,

                child: Column(
                  children: [
                    const SizedBox(height: 55),

                    // Icon
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_outlined,
                        size: 55,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Title
                    const Text(
                      'Verify Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Description
                    const Text(
                      'Enter the verification code sent to your email address',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40), // OTP
                    OtpInputField(
                      controllers: otpControllers,
                      focusNodes: otpFocusNodes,
                    ),

                    const SizedBox(height: 30),

                    // Verify Button
                    CustomButton(
                      text: isLoading ? 'Verifying...' : 'Verify',
                      onPressed: isLoading ? null : verifyOtp,
                    ),

                    const SizedBox(height: 20),

                    // Resend Code
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              // سنربط إعادة إرسال OTP لاحقًا.
                            },
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
