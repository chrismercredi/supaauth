import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../src.dart';

/// A form widget used in the forgot password process.
///
/// This widget provides a form where users can enter their email address to
/// initiate a password reset process. It uses [FormRegex.authValidateEmail]
/// for email validation and [SupabaseAuthCubit] to handle the reset password functionality.
class ForgotPasswordForm extends StatefulWidget {
  /// Creates a [ForgotPasswordForm] widget.
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  // Form key to manage form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text editing controller for email field
  late final TextEditingController _emailController = TextEditingController();
  // State to manage loading status during password reset
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Handles the logic for password reset when the form is submitted.
  ///
  /// Validates the email field and, if valid, triggers the password reset process
  /// via the [SupabaseAuthCubit]. Also manages the loading state during the process.
  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      context
          .read<SupabaseAuthCubit>()
          .resetPasswordForEmail(
            _emailController.text.trim(),
          )
          .whenComplete(() => setState(() => _isLoading = false));
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
            validator: (value) => FormRegex.authValidateEmail(value),
            style: Theme.of(context).emailTextStyle(),
            cursorColor: Theme.of(context).emailCursorColor,
            cursorWidth: Theme.of(context).emailCursorWidth,
            decoration: Theme.of(context).emailInputDecoration(),
          ),
          const Gap(24),
          AuthButton(
            isLoading: _isLoading,
            buttonText: 'Reset Password',
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
