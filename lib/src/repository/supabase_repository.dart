import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Thrown when an authentication error occurs in Supabase.
class SupabaseAuthException implements Exception {
  /// A message describing the authentication error.
  final String message;

  /// Creates a new SupabaseAuthException with the provided message.
  SupabaseAuthException(this.message);

  @override
  String toString() => 'Authentication Error: $message';
}

/// A repository that interacts with Supabase authentication.
class SupabaseRepository {
  /// The Supabase client used to interact with the Supabase API.
  final SupabaseClient client;

  /// Creates a new SupabaseRepository with the provided Supabase client.
  SupabaseRepository({required this.client});

  /// Returns the currently signed-in user, or `null` if no user is signed in.
  User? getCurrentUser() {
    return client.auth.currentUser;
  }

  /// A stream of authentication state changes.
  Stream<AuthState> get onAuthStateChange {
    return client.auth.onAuthStateChange;
  }

  /// Signs up a user with the given [email] and [password].
  ///
  /// Throws a [SupabaseAuthException] if the sign-up fails.
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

  /// Sends a password reset email to the given [email].
  ///
  /// Throws a [SupabaseAuthException] if the password reset fails.
  Future<void> resetPasswordForEmail({required String email}) async {
    try {
      await client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw SupabaseAuthException('Failed to reset password');
    }
  }

  /// Signs in a user with the given [email] and [password].
  ///
  /// Throws a [SupabaseAuthException] if the sign-in fails.
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

  /// Signs out the current user.
  ///
  /// Throws a [SupabaseAuthException] if the sign-out fails.
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw SupabaseAuthException('Failed to sign out');
    }
  }
}
