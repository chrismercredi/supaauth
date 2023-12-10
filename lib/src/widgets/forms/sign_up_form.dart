import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../src.dart';

/// A stateful widget that provides a user interface for user sign-up.
///
/// This widget presents a form for the user to input their email, password, and confirm the password.
/// It handles the sign-up logic, including form validation and interaction with authentication services.
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  // Form key to manage form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text editing controllers for email, password, and confirm password fields
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _confirmPasswordController =
      TextEditingController();
  // State to manage password visibility
  bool _isPasswordVisible = false;
  // State to manage loading status during sign-up
  bool _isLoading = false;

  /// Toggles the visibility of the password and confirm password fields.
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles the sign-up logic when the sign-up button is pressed.
  ///
  /// Validates the form and, if valid, performs a sign-up operation.
  void _signUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      context
          .read<SupabaseAuthCubit>()
          .signUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          )
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email input field
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
          // Password input field
          TextFormField(
            controller: _passwordController,
            validator: (value) =>
                FormRegex.authValidatePassword(_passwordController.text),
            obscureText: !_isPasswordVisible,
            style: Theme.of(context).passwordTextStyle(),
            cursorColor: Theme.of(context).passwordCursorColor,
            cursorWidth: Theme.of(context).passwordCursorWidth,
            decoration: Theme.of(context).passwordInputDecoration(
              onTogglePasswordVisibility: _togglePasswordVisibility,
              isPasswordVisible: _isPasswordVisible,
            ),
          ),
          const Gap(8),
          // Confirm password input field
          TextFormField(
            controller: _confirmPasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            obscureText: !_isPasswordVisible,
            style: Theme.of(context).confirmPasswordTextStyle(),
            cursorColor: Theme.of(context).confirmPasswordCursorColor,
            cursorWidth: Theme.of(context).confirmPasswordCursorWidth,
            decoration: Theme.of(context).confirmPasswordInputDecoration(
              onTogglePasswordVisibility: _togglePasswordVisibility,
              isPasswordVisible: _isPasswordVisible,
            ),
          ),
          const Gap(24),
          // Sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              style: Theme.of(context).blackSquareButtonStyle(),
              child: Text(_isLoading ? 'Signing Up...' : 'Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
