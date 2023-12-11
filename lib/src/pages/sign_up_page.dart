import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../src.dart';

/// A page widget for handling user sign-up.
///
/// This page provides a user interface for signing up to the application. It includes
/// form fields for user input and uses [SupabaseAuthCubit] for managing authentication state.
///
/// The `SignUpPage` is structured with a scaffold that includes various authentication
/// related widgets like `AuthHeader`, `AuthSVGImage`, `AuthPrompt`, and `SignUpForm`.
class SignUpPage extends StatelessWidget {
  /// Creates a [SignUpPage] widget.
  ///
  /// This widget is typically used in the context of navigation, where it can be
  /// routed to via [routeName].
  const SignUpPage({super.key});

  /// The route name for navigating to the sign-up page.
  static const String routeName = '/sign-up-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('sign-up-page'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Theme.of(context).formColumnPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthHeader(title: 'Sign Up'),
                const Gap(36),
                const AuthSVGImage(
                  assetName: 'assets/svg/undraw_sign_up_n6im.svg',
                ),
                const Gap(36),
                const AuthPrompt(
                  description: 'Sign up with your email address.',
                ),
                const Gap(24),
                BlocConsumer<SupabaseAuthCubit, SupabaseAuthState>(
                  listener: (context, state) {
                    if (state is SupabaseAuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    } else if (state is SupabaseAuthAuthenticated) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is SupabaseAuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const SignUpForm();
                  },
                ),
                const Gap(8),
                AuthTextButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
