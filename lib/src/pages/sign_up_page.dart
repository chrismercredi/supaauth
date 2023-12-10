import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../src.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                const AuthHeader(title: 'Sign up!'),
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
                      Navigator.of(context).pop(); // Example action
                    }
                  },
                  builder: (context, state) {
                    if (state is SupabaseAuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const SignUpForm();
                  },
                ),
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
