import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = '/login-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('login-page'),
      appBar: AppBar(
        actions: const [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: const Text('Login Page'),
                subtitle: const Text('Login to your account'),
                trailing:
                    TextButton(onPressed: () {}, child: const Text('Sign Up')),
              ),
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
    );
  }
}
