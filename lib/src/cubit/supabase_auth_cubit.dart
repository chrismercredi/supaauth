import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../src.dart';

part 'supabase_auth_state.dart';

/// [SupabaseAuthCubit] is a BLoC pattern class that manages the authentication states
/// using the Supabase authentication system. It listens to authentication state changes
/// and emits corresponding states for the UI to react accordingly.
///
/// Example:
/// ```dart
/// final supabaseRepository = SupabaseRepository();
/// final supabaseAuthCubit = SupabaseAuthCubit(supabaseRepository: supabaseRepository);
/// ```
class SupabaseAuthCubit extends Cubit<SupabaseAuthState> {
  final SupabaseRepository supabaseRepository;
  StreamSubscription<AuthState>? _authSubscription;

  /// Creates an instance of [SupabaseAuthCubit] with the given [supabaseRepository].
  /// The initial state is [SupabaseAuthInitial].
  SupabaseAuthCubit({required this.supabaseRepository})
      : super(SupabaseAuthInitial()) {
    _init();
  }

  /// Initializes the auth state based on the current user's state.
  /// Subscribes to the auth state changes and emits respective states.
  void _init() {
    final user = supabaseRepository.getCurrentUser();
    if (user != null) {
      emit(SupabaseAuthAuthenticated(user));
    } else {
      emit(SupabaseAuthUnauthenticated());
    }

    _authSubscription = supabaseRepository.onAuthStateChange.listen(
      (AuthState state) {
        final user = state.session?.user;
        if (user != null) {
          emit(SupabaseAuthAuthenticated(user));
        } else {
          emit(SupabaseAuthUnauthenticated());
        }
      },
      onError: (error) {
        emit(const SupabaseAuthError(
            'An error occurred while listening to authentication state changes'));
      },
    );
  }

  /// Triggers the sign-in state for modal sheets or user interactions.
  void showSignIn() {
    emit(SupabaseAuthSignIn());
  }

  /// Triggers the sign-up state for modal sheets or user interactions.
  void showSignUp() {
    emit(SupabaseAuthSignUp());
  }

  /// Triggers the forgot password state for modal sheets or user interactions.
  void showForgotPassword() {
    emit(SupabaseAuthForgotPassword());
  }

  /// Handles the user sign-up process with the given [email] and [password].
  /// Emits loading state during the process, and appropriate state upon completion or error.
  Future<void> signUp(String email, String password) async {
    try {
      emit(SupabaseAuthLoading());
      final user =
          await supabaseRepository.signUp(email: email, password: password);
      if (user != null) {
        emit(SupabaseAuthAuthenticated(user));
      } else {
        emit(const SupabaseAuthError('Sign up failed'));
      }
    } catch (e) {
      emit(SupabaseAuthError(
          'An error occurred during sign up: ${e.toString()}'));
    }
  }

  /// Handles the user sign-in process with the given [email] and [password].
  /// Emits loading state during the process, and appropriate state upon completion or error.
  Future<void> signIn(String email, String password) async {
    try {
      emit(SupabaseAuthLoading());
      final user =
          await supabaseRepository.signIn(email: email, password: password);
      if (user != null) {
        emit(SupabaseAuthAuthenticated(user));
      } else {
        emit(const SupabaseAuthError('Sign in failed'));
      }
    } catch (e) {
      emit(SupabaseAuthError(
          'An error occurred during sign in: ${e.toString()}'));
    }
  }

  /// Handles the user sign-out process.
  /// Emits unauthenticated state upon completion or error state in case of failure.
  Future<void> signOut() async {
    try {
      await supabaseRepository.signOut();
      emit(SupabaseAuthUnauthenticated());
    } catch (e) {
      emit(SupabaseAuthError('Sign out failed: ${e.toString()}'));
    }
  }

  /// Sends a password reset email to the given [email].
  /// Emits a password reset state or an error state in case of failure.
  Future<void> resetPasswordForEmail(String email) async {
    try {
      emit(SupabaseAuthLoading());
      await supabaseRepository.resetPasswordForEmail(email: email);
      emit(SupabaseAuthPasswordReset(
          'Password reset email sent to $email. Please check your inbox.'));
    } catch (e) {
      emit(SupabaseAuthError('Password reset failed: ${e.toString()}'));
    }
  }

  /// Overrides the close method to cancel any subscriptions before closing the cubit.
  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
