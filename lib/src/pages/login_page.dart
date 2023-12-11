import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../src.dart';

/// A page widget for handling user login.
///
/// This page provides a user interface for users to log into the application. It includes
/// form fields for user input and uses [SupabaseAuthCubit] for managing authentication state.
///
/// The `LoginPage` is structured with a scaffold that includes various authentication
/// related widgets like `AuthHeader`, `AuthSVGImage`, `AuthPrompt`, and `LoginForm`.
/// It also provides a link to the sign-up page and the forgot password page.
class LoginPage extends StatelessWidget {
  /// Creates a [LoginPage] widget.
  ///
  /// This widget is typically used in the context of navigation, where it can be
  /// routed to via [routeName].
  const LoginPage({super.key});

  /// The route name for navigating to the login page.
  static const String routeName = '/login-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('login-page'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Theme.of(context).formColumnPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthHeader(
                  title: 'Login',
                ),
                const Gap(24),
                const AuthSVGImage(
                  assetName: 'assets/svg/undraw_login_re_4vu2.svg',
                ),
                const Gap(24),
                AuthPrompt(
                  description: 'Need an account?',
                  buttonText: 'Sign up!',
                  onButtonPressed: () {
                    Navigator.of(context).pushNamed(SignUpPage.routeName);
                  },
                ),
                const Gap(16),
                BlocConsumer<SupabaseAuthCubit, SupabaseAuthState>(
                  listener: (context, state) {
                    if (state is SupabaseAuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SupabaseAuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const LoginForm();
                  },
                ),
                const Gap(8),
                AuthTextButton(
                  text: 'Forgot Password?',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/forgot-password-page');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
