part of 'supabase_auth_cubit.dart';

/// Represents the base class for all authentication states.
///
/// This abstract class acts as a foundation for various states
/// in the authentication process. Extending this class ensures a consistent
/// and predictable structure for all derived states.
abstract class SupabaseAuthState extends Equatable {
  const SupabaseAuthState();

  @override
  List<Object?> get props => [];
}

/// Represents the initial state of authentication.
///
/// This state is emitted immediately when the [SupabaseAuthCubit] is instantiated,
/// indicating that the authentication status has not been determined yet.
class SupabaseAuthInitial extends SupabaseAuthState {}

/// Represents the authenticated state of a user.
///
/// This state is emitted when a user successfully authenticates.
/// It carries the authenticated [user] object for further use.
class SupabaseAuthAuthenticated extends SupabaseAuthState {
  final User user;

  const SupabaseAuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// Represents an error state in the authentication process.
///
/// Emitted when an error occurs during an authentication operation.
/// Contains a [message] describing the error.
class SupabaseAuthError extends SupabaseAuthState {
  final String message;

  const SupabaseAuthError(this.message);

  @override
  List<Object> get props => [message];
}

/// State for displaying the forgot password interface.
///
/// Emitted to prompt the UI to display a forgot password form or modal.
class SupabaseAuthForgotPassword extends SupabaseAuthState {}

/// Represents the loading state during authentication processes.
///
/// Emitted during any ongoing asynchronous authentication operation, such as
/// signing in, signing up, or signing out, to indicate that the operation is in progress.
class SupabaseAuthLoading extends SupabaseAuthState {}

/// State for displaying the sign-in interface.
///
/// Emitted to prompt the UI to display a sign-in form or modal.
class SupabaseAuthSignIn extends SupabaseAuthState {}

/// State for displaying the sign-up interface.
///
/// Emitted to prompt the UI to display a sign-up form or modal.
class SupabaseAuthSignUp extends SupabaseAuthState {}

/// State indicating a password reset operation.
///
/// Emitted after a request to reset a password is made.
/// Contains a [message] usually informing the user to check their email.
class SupabaseAuthPasswordReset extends SupabaseAuthState {
  final String message;

  const SupabaseAuthPasswordReset(this.message);

  @override
  List<Object> get props => [message];
}

/// State indicating a password recovery operation.
///
/// Emitted when the application detects a password recovery event.
/// Could carry necessary data like a recovery token if applicable.
class SupabaseAuthStatePasswordRecovery extends SupabaseAuthState {}

/// State indicating the start of the password update process.
class SupabaseAuthUpdatePassword extends SupabaseAuthState {}

/// State indicating the successful completion of the password update process.
class SupabaseAuthPasswordUpdated extends SupabaseAuthState {
  final String message;

  const SupabaseAuthPasswordUpdated(this.message);

  @override
  List<Object> get props => [message];
}

/// Represents the unauthenticated state of a user.
///
/// This state is emitted when a user is not authenticated,
/// such as after logging out or when no user session is present.
class SupabaseAuthUnauthenticated extends SupabaseAuthState {}
