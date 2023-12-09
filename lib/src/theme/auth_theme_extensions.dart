import 'package:flutter/material.dart';

extension AuthThemeExtensions on ThemeData {
  get pageColumnPadding => const EdgeInsets.fromLTRB(40.0, 0, 40, 0);

  get formColumnPadding => const EdgeInsets.fromLTRB(40.0, 0, 40, 0);

  InputDecoration emailInputDecoration() {
    return const InputDecoration(
      labelText: 'Email',
      labelStyle: TextStyle(
        color: Colors.black, // Label text color when it's not focused
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when focused
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when not focused
      ),
      // Adding cursor color here won't work, as it's not part of InputDecoration
    );
  }

  // Define a method for common text style
  TextStyle emailTextStyle() {
    return const TextStyle(
      color: Colors.black, // Text color
    );
  }

  // Define methods for cursor
  Color get emailCursorColor => Colors.black;
  double get emailCursorWidth => 8;

  InputDecoration passwordInputDecoration({
    required VoidCallback onTogglePasswordVisibility,
    required bool isPasswordVisible,
  }) {
    return InputDecoration(
      labelText: 'Password',
      labelStyle: const TextStyle(
        color: Colors.black, // Label text color
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when focused
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when not focused
      ),
      suffixIcon: IconButton(
        icon: Icon(
          // Toggle the icon based on password visibility
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
        onPressed: onTogglePasswordVisibility,
      ),
    );
  }

  // New method for the ElevatedButton style
  ButtonStyle blackSquareButtonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black, // Text color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Square corners
      ),
    );
  }

  // New method for the TextButton style
  ButtonStyle blackTextButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Square corners
      ), // Text color
    );
  }

  // New method for the OutlinedButton style
  ButtonStyle blackOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Square corners
      ),
      side: const BorderSide(color: Colors.black), // Black border
    );
  }

  InputDecoration referralInputDecoration() {
    return const InputDecoration(
      labelText: 'Referral code(optional)',
      labelStyle: TextStyle(
        color: Colors.black, // Label text color when it's not focused
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when focused
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.black), // Underline color when not focused
      ),
      // Adding cursor color here won't work, as it's not part of InputDecoration
    );
  }
}
