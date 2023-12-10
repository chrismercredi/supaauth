import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const String routeName = '/sign-up-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('sign-up-page'),
      appBar: AppBar(
        actions: const [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Theme.of(context).formColumnPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign up!'),
                        Text('Sign up with your email address'),
                      ],
                    ),
                  ],
                ),
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
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Cancel'),
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
