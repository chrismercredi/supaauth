import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../src.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key, required this.child});

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
