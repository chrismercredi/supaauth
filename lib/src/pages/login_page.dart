import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../src.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                SizedBox(
                  width: double.infinity,
                  child: AuthTextButton(
                    text: 'Forgot Password?',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/forgot-password-page');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
