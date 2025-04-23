# Authentication Widgets

This directory contains widgets that are specific to the authentication feature of the application.

## Component Organization

- `animated_logo.dart` - Component that adds floating, rotation, and pulsing animations to logos and other UI elements specific to auth screens
- `auth_text_field.dart` - Specialized text field component optimized for authentication forms
- `court_logo.dart` - The court logo displayed on auth screens
- Other auth-specific widgets

## Refactoring Notes

- The `animated_logo_container.dart` component was originally placed in `shared/components/layouts/` but has been consolidated with `animated_logo.dart` since both provide similar functionality specifically for the auth feature.
- The `auth_text_field.dart` was moved from `shared/components/inputs/` to this directory as it's specialized for authentication forms rather than being a truly generic input component.

## Usage

Import these components directly in your auth-related screens:

```dart
import 'package:project/features/auth/presentation/widgets/animated_logo.dart';
import 'package:project/features/auth/presentation/widgets/auth_text_field.dart';
``` 