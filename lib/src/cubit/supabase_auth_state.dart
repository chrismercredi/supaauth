part of 'supabase_auth_cubit.dart';

/// Base class for authentication states.
///
/// All specific authentication states extend from this class.
/// This design makes it easy to handle all authentication states in a
/// consistent manner using the Bloc library.
sealed class SupabaseAuthState extends Equatable {
  const SupabaseAuthState();

  @override
  List<Object> get props => [];
}

/// Initial authentication state.
///
/// This state is emitted when the [SupabaseAuthCubit] is first created,
/// before any authentication checks have been performed.
class SupabaseAuthInitial extends SupabaseAuthState {}

/// Loading state for authentication processes.
///
/// This state is emitted whenever an asynchronous authentication operation,
/// such as sign-up, sign-in, or sign-out, is in progress.
class SupabaseAuthLoading extends SupabaseAuthState {}

class SupabaseAuthSignIn extends SupabaseAuthState {}

class SupabaseAuthSignUp extends SupabaseAuthState {}

class SupabaseAuthForgotPassword extends SupabaseAuthState {}

/// Authenticated state.
///
/// This state is emitted when a user is successfully authenticated.
/// It contains the authenticated user.
class SupabaseAuthAuthenticated extends SupabaseAuthState {
  final User user;

  const SupabaseAuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// Unauthenticated state.
///
/// This state is emitted when a user is not authenticated.
/// It could be the result of a sign-out operation or if no user is signed in.
class SupabaseAuthUnauthenticated extends SupabaseAuthState {}

/// Error state for authentication processes.
///
/// This state is emitted when an error occurs during an authentication operation.
/// It contains a descriptive error message.
class SupabaseAuthError extends SupabaseAuthState {
  final String message;

  const SupabaseAuthError(this.message);

  @override
  List<Object> get props => [message];
}

class SupabaseAuthPasswordReset extends SupabaseAuthState {
  final String message;

  const SupabaseAuthPasswordReset(this.message);

  @override
  List<Object> get props => [message];
}
