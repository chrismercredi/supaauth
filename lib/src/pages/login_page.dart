import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Staatliches',
                      package: 'supaauth'),
                ),
                const Gap(24),
                SvgPicture.asset(
                  'assets/svg/undraw_login_re_4vu2.svg',
                  package: 'supaauth',
                  width: 300,
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Need an account?'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignUpPage.routeName);
                          },
                          style: Theme.of(context).blackTextButtonStyle(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Sign up!'),
                          ),
                        ),
                      ],
                    ),
                  ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
