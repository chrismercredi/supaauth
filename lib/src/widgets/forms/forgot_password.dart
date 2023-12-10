import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../src.dart';

class ForgotPasswordForm extends StatefulWidget {
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
  final bool _isLoading = false;

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
          const Gap(24),
          AuthButton(
            isLoading: _isLoading,
            buttonText: 'Reset Password',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<SupabaseAuthCubit>().resetPasswordForEmail(
                      _emailController.text.trim(),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
