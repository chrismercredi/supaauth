import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../src.dart';

/// A form widget used for user login.
///
/// This widget provides a form where users can enter their email and password
/// for logging into the application. It uses [FormRegex] for validation and
/// [SupabaseAuthCubit] for handling the login functionality.
class LoginForm extends StatefulWidget {
  /// Creates a [LoginForm] widget.
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  // Form key to manage form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text editing controllers for email and password fields
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

  /// Handles the login logic when the login button is pressed.
  ///
  /// Validates the form fields and, if valid, initiates a login process
  /// via the [SupabaseAuthCubit].
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
          AuthButton(
            isLoading: _isLoading,
            buttonText: _isLoading ? 'Loading' : 'Login',
            onPressed: _login,
          ),
        ],
      ),
    );
  }
}
