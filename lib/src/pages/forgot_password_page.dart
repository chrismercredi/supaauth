import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../src.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const String routeName = '/forgot-password-page';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  late final TextEditingController _emailController = TextEditingController();

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
    return Scaffold(
      key: const Key('forgot-password-page'),
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Theme.of(context).formColumnPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Staatliches',
                      package: 'supaauth'),
                ),
                const Gap(24),
                SvgPicture.asset(
                  'assets/svg/undraw_forgot_password_re_hxwm.svg',
                  package: 'supaauth',
                  width: 300,
                ),
                const Gap(24),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('''It happens. We'll help you reset it.'''),
                      ],
                    ),
                  ],
                ),
                const Gap(24),
                Form(
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    // Forgot password logic here
                                  }
                                },
                          style: Theme.of(context).blackSquareButtonStyle(),
                          child:
                              Text(_isLoading ? 'Loading' : 'Reset Password'),
                        ),
                      ),
                      const Gap(8),
                      SizedBox(
                        width: double
                            .infinity, // Make the button expand horizontally
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: Theme.of(context).blackTextButtonStyle(),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
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
