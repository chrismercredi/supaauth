import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../src.dart';

/// A wrapper widget for providing the necessary dependencies for Supabase authentication.
///
/// This widget uses `RepositoryProvider` and `BlocProvider` to inject
/// `SupabaseRepository` and `SupabaseAuthCubit` into the widget tree. This setup
/// ensures that these dependencies are available to the widgets that need them.
///
/// The `SupauthWrapper` should be placed above the widget subtree that requires
/// authentication-related functionality.
///
/// [child] is the widget below this wrapper in the widget tree.
class SupauthWrapper extends StatelessWidget {
  /// Creates a [SupauthWrapper].
  ///
  /// The [child] parameter is required and should contain the widget subtree
  /// that needs access to authentication functionality.
  const SupauthWrapper({super.key, required this.child});

  /// The widget below this wrapper in the widget tree.
  ///
  /// This subtree can now access the authentication-related functionalities
  /// provided by `SupabaseRepository` and `SupabaseAuthCubit`.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => SupabaseRepository(
        client: Supabase.instance.client,
      ),
      child: BlocProvider(
        create: (context) => SupabaseAuthCubit(
          supabaseRepository: context.read<SupabaseRepository>(),
        ),
        child: child,
      ),
    );
  }
}
