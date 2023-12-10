/// A utility class for form validation, particularly for authentication purposes.
///
/// Contains static methods to validate email and password fields according to
/// specified patterns and rules.
class FormRegex {
  /// Validates an email address for authentication forms.
  ///
  /// Checks if the email is non-empty and ends with 'gmail.com' or 'icloud.com'.
  /// Returns an error message if the validation fails, or `null` if it passes.
  ///
  /// [value] is the email address to validate.
  static String? authValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    String pattern = r'(gmail\.com|icloud\.com)$';
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Email must end with gmail.com or icloud.com';
    }
    return null;
  }

  /// Validates a password for authentication forms.
  ///
  /// Checks if the password is non-empty, at least 8 characters long, contains at least one
  /// number, and at least one special character (among @, $, !, %, *, ?, or &).
  /// Returns an error message if the validation fails, or `null` if it passes.
  ///
  /// [value] is the password to validate.
  static String? authValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    bool hasMinLength = value.length >= 8;
    bool hasNumber = value.contains(RegExp(r'\d'));
    // Escaping special characters like $, *, and ?
    bool hasSpecialChar = value.contains(RegExp(r'[@\$!%*?&]'));

    if (!hasMinLength) {
      return 'Password must be at least 8 characters';
    }
    if (!hasNumber) {
      return 'Include at least one number';
    }
    if (!hasSpecialChar) {
      return 'Include at least one symbol (@, \$, !, %, *, ?, or &)';
    }

    return null;
  }
}
