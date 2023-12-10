import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Staatliches',
                      package: 'supaauth'),
                ),
                const Gap(36),
                SvgPicture.asset(
                  'assets/svg/undraw_sign_up_n6im.svg',
                  package: 'supaauth',
                  width: 300,
                ),
                const Gap(36),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign up with your email address.'),
                      ],
                    ),
                  ],
                ),
                const Gap(24),
                BlocConsumer<SupabaseAuthCubit, SupabaseAuthState>(
                  listener: (context, state) {
                    if (state is SupabaseAuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    } else if (state is SupabaseAuthAuthenticated) {
                      // Handle navigation or actions after successful signup if needed
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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: Theme.of(context).blackTextButtonStyle(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
