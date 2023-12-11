import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_auth_example/app_bloc_observer.dart';
import 'package:supaauth/supaauth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

import 'env.dart';

/// Entry point of the Flutter application.
///
/// It initializes the necessary Flutter bindings, sets up the BLoC observer,
/// configures the URL strategy for web, and initializes the Supabase client.
/// Finally, it runs the main application widget, [SupauthWrapper].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  // Removes the '#' from the URLs in web applications.
  usePathUrlStrategy();

  // Initialize Supabase client with a URL and an anonymous key.
  // These should be replaced with your specific Supabase project URL and key.
  // const supabaseUrl = 'https://<your-project-id>.supabase.co';
  // const supabaseAnonKey = '<your-anon-key>';

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

/// The root widget of the Flutter application.
///
/// This [StatefulWidget] is responsible for managing the state and navigation
/// of the app. It also sets up routing for different pages of the app.
class SupaAuthExample extends StatefulWidget {
  /// Constructs a [SupaAuthExample].
  const SupaAuthExample({Key? key}) : super(key: key);

  @override
  State<SupaAuthExample> createState() => _SupaAuthExampleState();
}

class _SupaAuthExampleState extends State<SupaAuthExample> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  /// Returns the current state of the navigator.
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<SupabaseAuthCubit, SupabaseAuthState>(
          listener: (context, state) {
            if (state is SupabaseAuthStatePasswordRecovery) {
              _navigator.push(MaterialPageRoute(
                builder: (context) => const UpdatePasswordPage(
                  successRoute: HomePage.routeName,
                ),
              ));
            }
            if (state is SupabaseAuthUnauthenticated) {
              _navigator.pushNamedAndRemoveUntil(
                LoginPage.routeName,
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      initialRoute: HomePage.routeName,
      navigatorObservers: [MyRouteObserver()],
      onGenerateRoute: (settings) => _generateRoute(settings),
    );
  }

  /// Generates routes based on the given [RouteSettings].
  ///
  /// The method defines the navigation logic for navigating to different pages
  /// such as [SignUpPage], [LoginPage], [ForgotPasswordPage], and a default route.
  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignUpPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignUpPage(),
          settings: settings,
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(
            successRoute: HomePage.routeName,
          ),
          settings: settings,
        );
      case ForgotPasswordPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
          settings: settings,
        );
      default:
        // Default route
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: settings,
        );
    }
  }
}

/// Represents the home page of the application.
///
/// This widget defines the layout and functionality of the home page,
/// including the app bar and main content.
class HomePage extends StatelessWidget {
  /// Constructs a [HomePage].
  const HomePage({super.key});

  /// The route name for the home page.
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupaAuth example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<SupabaseAuthCubit>().signOut();
            },
          ),
        ],
      ),
      body: const Text('Home page'),
    );
  }
}

/// A custom [RouteObserver] that logs route changes.
///
/// This observer is used to monitor and log the navigation events
/// such as pushing and popping routes in the application.
class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    print('Pushed route: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print('Popped route: ${route.settings.name}');
  }
}
