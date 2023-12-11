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
  /// If the sign-up is successful but email confirmation is required,
  /// the user is returned with a null session.
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response =
          await client.auth.signUp(email: email, password: password);

      final Session? session = response.session;
      final User? user = response.user;

      // Checking if the user was successfully created.
      if (user != null) {
        if (session != null) {
          // User signed up and logged in successfully (Confirm email disabled).
          return user;
        } else {
          // User needs to confirm their email address (Confirm email enabled).
          return user;
        }
      } else {
        // Handle case when user is null - unexpected since no exception was thrown.
        // Note: Supabase doesn't restrict users from signing up with the same email.
        // see this thread: https://github.com/supabase/supabase-js/issues/296
        throw SupabaseAuthException(
            'Sign up failed: Unexpected error occurred');
      }
    } on AuthException catch (e) {
      // Handling errors from Supabase Auth
      throw SupabaseAuthException('Failed to sign up: ${e.message}');
    } catch (e) {
      // Handling other types of exceptions
      throw SupabaseAuthException('Failed to sign up: ${e.toString()}');
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

  /// Sends a reauthentication nonce to the user's email or phone number.
  ///
  /// This method is used in conjunction with updateUser() when a user's
  /// password needs to be updated with a nonce.
  Future<void> sendReauthenticationNonce() async {
    try {
      await client.auth.reauthenticate();
    } catch (e) {
      throw SupabaseAuthException(
          'Failed to send reauthentication nonce: ${e.toString()}');
    }
  }

  /// Updates the password for the currently authenticated user.
  /// Optionally uses a nonce for secure password change.
  ///
  /// Throws a [SupabaseAuthException] if the update process fails.
  Future<void> updateUserPassword(
      {required String newPassword, String? nonce}) async {
    try {
      // Ensure there is a logged-in user
      final currentUser = client.auth.currentUser;
      if (currentUser == null) {
        throw SupabaseAuthException(
            'No authenticated user to update password for.');
      }

      // Prepare user attributes for update
      final UserAttributes attributes = nonce == null
          ? UserAttributes(password: newPassword)
          : UserAttributes(password: newPassword, nonce: nonce);

      // Update user password
      final UserResponse response = await client.auth.updateUser(attributes);

      // Check if the response user is null, indicating an unsuccessful update
      if (response.user == null) {
        throw SupabaseAuthException('Failed to update password.');
      }
    } catch (e) {
      // Handling errors from Supabase Auth and other exceptions
      throw SupabaseAuthException('Failed to update password: ${e.toString()}');
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
