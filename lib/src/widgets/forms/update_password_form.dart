import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../src.dart';

/// A stateful widget that provides a user interface for resetting the user's password.
///
/// This widget presents a form for the user to input their new password and confirm it.
/// It handles the password reset logic, including form validation and interaction with authentication services.
class UpdatePasswordForm extends StatefulWidget {
  const UpdatePasswordForm({super.key});

  @override
  State<UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> {
  // Form key to manage form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text editing controllers for new password and confirm new password fields
  late final TextEditingController _newPasswordController =
      TextEditingController();
  late final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  // State to manage password visibility
  bool _isNewPasswordVisible = false;
  // State to manage loading status during password reset
  bool _isLoading = false;

  /// Toggles the visibility of the new password and confirm new password fields.
  void _toggleNewPasswordVisibility() {
    setState(() {
      _isNewPasswordVisible = !_isNewPasswordVisible;
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  /// Handles the password reset logic when the reset button is pressed.
  ///
  /// Validates the form and, if valid, performs a password reset operation.
  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      context
          .read<SupabaseAuthCubit>()
          .updatePassword(_newPasswordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // New password input field
          TextFormField(
            controller: _newPasswordController,
            validator: (value) =>
                FormRegex.authValidatePassword(_newPasswordController.text),
            obscureText: !_isNewPasswordVisible,
            style: Theme.of(context).passwordTextStyle(),
            cursorColor: Theme.of(context).passwordCursorColor,
            cursorWidth: Theme.of(context).passwordCursorWidth,
            decoration: Theme.of(context).passwordInputDecoration(
              onTogglePasswordVisibility: _toggleNewPasswordVisibility,
              isPasswordVisible: _isNewPasswordVisible,
            ),
          ),
          const Gap(8),
          // Confirm new password input field
          TextFormField(
            controller: _confirmNewPasswordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _newPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            obscureText: !_isNewPasswordVisible,
            style: Theme.of(context).confirmPasswordTextStyle(),
            cursorColor: Theme.of(context).confirmPasswordCursorColor,
            cursorWidth: Theme.of(context).confirmPasswordCursorWidth,
            decoration: Theme.of(context).confirmPasswordInputDecoration(
              onTogglePasswordVisibility: _toggleNewPasswordVisibility,
              isPasswordVisible: _isNewPasswordVisible,
            ),
          ),
          const Gap(24),
          // Reset password button
          AuthButton(
            isLoading: _isLoading,
            buttonText: _isLoading ? 'Resetting...' : 'Reset Password',
            onPressed: _updatePassword,
          ),
        ],
      ),
    );
  }
}
