import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../src.dart';

/// `UpdatePasswordPage` - A widget for facilitating password updates during
/// the password recovery process in a Flutter application.
///
/// This page is typically presented in response to a password recovery event,
/// such as when a user accesses a password recovery link from an email.
///
/// Usage:
/// Ensure your Navigator is set up to react to the SupabaseAuthCubit state
/// for the password recovery scenario.
/// (e.g., `SupabaseAuthStatePasswordRecovery`). When this state is detected,
/// navigate to `UpdatePasswordPage`.
///
/// Example:
/// ```dart
/// BlocListener<SupabaseAuthCubit, SupabaseAuthState>(
///   listener: (context, state) {
///     if (state is SupabaseAuthStatePasswordRecovery) {
///       Navigator.of(context).push(MaterialPageRoute(
///         builder: (context) => const UpdatePasswordPage(),
///       ));
///     }
///   },
///   child: const HomePage(),
/// )
/// ```
///
/// Features:
/// - Scaffold layout with an AppBar.
/// - UI components for updating the password.
/// - Integration with Bloc for state management.
///
/// Navigation:
/// The page uses `Navigator.pop` to return to the previous screen upon successful
/// password update or when the user cancels the operation.
class UpdatePasswordPage extends StatelessWidget {
  /// The route name to navigate to after successful login.
  final String successRoute;

  /// Creates an instance of [UpdatePasswordPage].
  ///
  /// [token] - An optional parameter used to pre-fill the password reset form.
  /// If this token is provided via a deep link, pass it to this widget to streamline the user experience.
  const UpdatePasswordPage({super.key, required this.successRoute});

  /// Route name for navigating to this page.
  static const String routeName = '/update-password-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('update-password-page'),
      appBar: AppBar(title: const Text('Update Password')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Theme.of(context).formColumnPadding,
            child: BlocConsumer<SupabaseAuthCubit, SupabaseAuthState>(
              listener: (context, state) {
                if (state is SupabaseAuthPasswordUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password updated successfully'),
                    ),
                  );
                  Navigator.of(context).pushReplacementNamed(successRoute);
                }
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(title: 'Update Password'),
                    const Gap(24),
                    const AuthSVGImage(
                      assetName: 'assets/svg/undraw_my_password_re_ydq7.svg',
                    ),
                    const Gap(24),
                    const AuthPrompt(
                      description: 'Enter your new password below.',
                    ),
                    const Gap(24),
                    const UpdatePasswordForm(),
                    const Gap(8),
                    AuthTextButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
