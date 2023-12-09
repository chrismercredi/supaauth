import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../src.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  // ignore: prefer_final_fields
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<SupabaseAuthCubit>().signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) =>
                FormRegex.authValidateEmail(_emailController.text),
            style: Theme.of(context).emailTextStyle(),
            cursorColor: Theme.of(context).emailCursorColor,
            cursorWidth: Theme.of(context).emailCursorWidth,
            decoration: Theme.of(context).emailInputDecoration(),
          ),
          const Gap(8),
          TextFormField(
            controller: _passwordController,
            validator: (value) =>
                FormRegex.authValidatePassword(_passwordController.text),
            obscureText: !_isPasswordVisible,
            style: Theme.of(context).emailTextStyle(),
            cursorColor: Theme.of(context).emailCursorColor,
            cursorWidth: Theme.of(context).emailCursorWidth,
            decoration: Theme.of(context).passwordInputDecoration(
              onTogglePasswordVisibility: _togglePasswordVisibility,
              isPasswordVisible: _isPasswordVisible,
            ),
          ),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _login,
              style: Theme.of(context).blackSquareButtonStyle(),
              child: Text(_isLoading ? 'Loading' : 'Login'),
            ),
          ),
          const Gap(8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/forgot-password-page');
              },
              style: Theme.of(context).blackTextButtonStyle(),
              child: const Text('Forgot Password?'),
            ),
          ),
        ],
      ),
    );
  }
}
