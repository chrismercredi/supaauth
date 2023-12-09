import 'package:flutter/material.dart';
import 'package:supaauth/supaauth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = 'https://<your-project-id>.supabase.co';
  const supabaseAnonKey = '<your-anon-key>';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const SupaAuthExample());
}

class SupaAuthExample extends StatelessWidget {
  const SupaAuthExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Supabase Auth Example',
      home: AuthWrapper(
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaAuth example'),
      ),
      body: const LoginPage(),
    );
  }
}