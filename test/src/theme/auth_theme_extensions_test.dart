import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supaauth/src/theme/auth_theme_extensions.dart';

void main() {
  testWidgets('AuthThemeExtensions properties test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          final ThemeData theme = Theme.of(context);

          // Test for padding properties
          expect(theme.pageColumnPadding,
              const EdgeInsets.fromLTRB(40.0, 0, 40, 0));
          expect(theme.formColumnPadding,
              const EdgeInsets.fromLTRB(40.0, 0, 40, 0));

          // Test for TextStyle properties
          expect(
              theme.loginHeaderStyle,
              const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Staatliches',
                package: 'supaauth',
              ));
          expect(theme.emailTextStyle(), const TextStyle(color: Colors.black));
          expect(
              theme.passwordTextStyle(), const TextStyle(color: Colors.black));
          expect(theme.confirmPasswordTextStyle(),
              const TextStyle(color: Colors.black));

          // Test for Color properties
          expect(theme.emailCursorColor, Colors.black);
          expect(theme.passwordCursorColor, Colors.black);
          expect(theme.confirmPasswordCursorColor, Colors.black);

          // Test for cursor width
          expect(theme.emailCursorWidth, 4);
          expect(theme.passwordCursorWidth, 4);
          expect(theme.confirmPasswordCursorWidth, 4);

          // Test for InputDecoration
          expect(theme.emailInputDecoration().labelText, 'Email');
          expect(
              theme
                  .passwordInputDecoration(
                      onTogglePasswordVisibility: () {},
                      isPasswordVisible: false)
                  .labelText,
              'Password');
          expect(
              theme
                  .confirmPasswordInputDecoration(
                      onTogglePasswordVisibility: () {},
                      isPasswordVisible: false)
                  .labelText,
              'Confirm Password');

          return const Placeholder();
        }),
      ),
    ));
  });

  testWidgets('Black Square Button Style Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          final ButtonStyle style = Theme.of(context).blackSquareButtonStyle();

          // Check if the button has a black background color
          final MaterialStateProperty<Color?> backgroundColor =
              style.backgroundColor!;
          expect(backgroundColor.resolve({}), Colors.black);

          // Check if the button has the desired shape
          final MaterialStateProperty<OutlinedBorder?> shape = style.shape!;
          expect(
              shape.resolve({}),
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ));

          return const Placeholder();
        }),
      ),
    ));
  });
}
