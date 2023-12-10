import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Exception class for handling authentication errors in Supabase.
///
/// This class provides a structured way to handle and report authentication
/// errors that occur during interactions with the Supabase authentication system.
class SupabaseAuthException implements Exception {
  /// A descriptive message about the authentication error.
  final String message;

  /// Constructs a [SupabaseAuthException] with a specific error [message].
  SupabaseAuthException(this.message);

  @override
  String toString() => 'Authentication Error: $message';
}

/// Repository class for managing interactions with Supabase authentication services.
///
/// This class abstracts the details of interacting with the Supabase authentication API,
/// providing a more straightforward and simplified interface for authentication operations.
class SupabaseRepository {
  /// The Supabase client instance used for interacting with the Supabase services.
  final SupabaseClient client;

  /// Constructs a [SupabaseRepository] with the given Supabase [client].
  SupabaseRepository({required this.client});

  /// Retrieves the currently authenticated user, if any.
  ///
  /// Returns `null` if no user is currently signed in.
  User? getCurrentUser() {
    return client.auth.currentUser;
  }

  /// Returns a stream of authentication state changes.
  ///
  /// This stream can be listened to for real-time updates on the user's authentication state.
  Stream<AuthState> get onAuthStateChange {
    return client.auth.onAuthStateChange;
  }

  /// Signs up a new user with the provided [email] and [password].
  ///
  /// Throws a [SupabaseAuthException] if the sign-up process fails.
  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      final AuthResponse response = await client.auth.signUp(
        email: email,
        password: password,
      );
      return response.user;
    } catch (e) {
      throw SupabaseAuthException('Failed to sign up!');
    }
  }

  /// Initiates a password reset process for the given [email].
  ///
  /// Sends a password reset email to the specified address.
  /// Throws a [SupabaseAuthException] if unable to initiate the password reset.
  Future<void> resetPasswordForEmail({required String email}) async {
    try {
      await client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw SupabaseAuthException('Failed to reset password');
    }
  }

  /// Signs in a user using the specified [email] and [password].
  ///
  /// Throws a [SupabaseAuthException] if the sign-in process fails.
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } catch (e) {
      throw SupabaseAuthException('Failed to sign in');
    }
  }

  /// Signs out the currently authenticated user.
  ///
  /// Throws a [SupabaseAuthException] if the sign-out process fails.
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw SupabaseAuthException('Failed to sign out');
    }
  }
}
