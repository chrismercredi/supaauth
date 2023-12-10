import 'package:supaauth/src/utils/form_regex.dart';
import 'package:test/test.dart';

void main() {
  group('Email Validation Tests', () {
    test('Empty Email Test', () {
      var result = FormRegex.authValidateEmail('');
      expect(result, 'Email cannot be empty');
    });

    test('Invalid Email Test', () {
      var result = FormRegex.authValidateEmail('user@example.com');
      expect(result, 'Email must end with gmail.com or icloud.com');
    });

    test('Valid Email Test', () {
      var result = FormRegex.authValidateEmail('user@gmail.com');
      expect(result, isNull);
    });
  });

  group('Password Validation Tests', () {
    test('Empty Password Test', () {
      var result = FormRegex.authValidatePassword('');
      expect(result, 'Password cannot be empty');
    });

    test('Short Password Test', () {
      var result = FormRegex.authValidatePassword('Abc@1');
      expect(result, 'Password must be at least 8 characters');
    });

    test('Password Without Number Test', () {
      var result = FormRegex.authValidatePassword('Abcdefg@');
      expect(result, 'Include at least one number');
    });

    test('Password Without Special Character Test', () {
      var result = FormRegex.authValidatePassword('Abcdefg1');
      expect(result, 'Include at least one symbol (@, \$, !, %, *, ?, or &)');
    });

    test('Valid Password Test', () {
      var result = FormRegex.authValidatePassword('Abcdefg1@');
      expect(result, isNull);
    });
  });
}
