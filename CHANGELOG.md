## 0.0.2-alpha.1

### Added
- Created reusable UI components for authentication screens, including `AuthHeader`, `AuthSVGImage`, `AuthPrompt`, `AuthTextButton`, and `AuthButton`.
- Developed `ForgotPasswordForm` widget for handling forgot password functionality.
- Implemented theme extension `AuthThemeExtensions` to provide consistent styling across authentication-related components.

### Changed
- Refactored `LoginPage`, `SignUpPage`, and `ForgotPasswordPage` to utilize new reusable components for improved code maintainability and consistency.
- Enhanced `LoginForm` and `SignUpForm` to use `AuthButton` for a consistent UI experience.
- Modified `AuthThemeExtensions` to include styles for email, password, and confirm password input fields, as well as button styles.

### Fixed
- Addressed an issue with `AuthTextButton` not expanding to fill the available horizontal space by wrapping it in a `SizedBox` with `double.infinity` width.

### Testing
- Added unit tests for `FormRegex` validation methods to ensure robust email and password validation logic.
- Created widget tests for `AuthThemeExtensions` to verify the correct application of theme properties.

## 0.0.1-alpha.1

Initial release.
