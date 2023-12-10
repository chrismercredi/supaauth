# Supaauth

Supaauth is a Flutter package designed to streamline the process of implementing authentication in your Flutter applications. Leveraging the powerful `supabase_flutter` package for backend connectivity and Flutter Bloc for state management, Supaauth provides a set of ready-to-use authentication pages for a quick and efficient setup.

## Features

- **Ease of Use:** Simple and quick integration with Supabase for backend authentication.
- **Bloc State Management:** Utilizes Flutter Bloc for efficient state management in authentication flows.
- **Customizable UI:** Pre-designed authentication pages that can be easily customized to match your app's theme.
- **Secure:** Implements best practices to ensure secure handling of user authentication.


## Getting Started

To use Supaauth in your Flutter project, ensure you have Flutter installed and set up. You'll also need a Supabase account and project setup for backend functionality.

### Prerequisites
- Flutter SDK
- Supabase project

### Installation
Add Supaauth to your `pubspec.yaml`:

```yaml
dependencies:
  supaauth: ^0.0.1
```

Run `flutter pub get` to install the package.

## Usage

Supaauth simplifies the integration of authentication in your Flutter apps using Supabase. Here's a quick guide on how to get started:

First, make sure to add `supaauth` and `supabase_flutter` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  supaauth: ^0.0.1
  supabase_flutter: ^your_version
```

Then, initialize Supabase and set up your application to use Supaauth:

```dart
import 'package:flutter/material.dart';
import 'package:supaauth/supaauth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Replace with your Supabase project details
  const supabaseUrl = 'https://<your-project-id>.supabase.co';
  const supabaseAnonKey = '<your-anon-key>';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(
    const SupauthWrapper(
      child: SupaAuthExample(),
    ),
  );
}

class SupaAuthExample extends StatelessWidget {
  const SupaAuthExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Auth Example',
      home: const HomePage(),
      initialRoute: '/',
      routes: {
        SignUpPage.routeName: (context) => const SignUpPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage(),
      },
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
```

Replace `<your-project-id>` and `<your-anon-key>` with your actual Supabase project details.

This setup demonstrates a basic Flutter app using Supaauth for authentication pages like Sign Up, Login, and Forgot Password, integrated with Supabase's authentication system.

## Additional Information

This package is open-source and contributions are welcome. Feel free to fork the repository, submit pull requests, or file issues.

- **Find more information:** Visit [GitHub repository](https://github.com/chrismercredi/supaauth)
- **Contribute:** I appreciate contributions! 
- **Issues:** Report issues on the GitHub repository's issues section.
- **Support:** For questions and support, raise an issue.

I aim to respond to issues and pull requests promptly for a smooth developer experience.

## GitHub code spaces
Use this command to run in GitHub codespace:
```
flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3000
```