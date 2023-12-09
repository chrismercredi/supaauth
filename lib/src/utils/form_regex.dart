class FormRegex {
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
