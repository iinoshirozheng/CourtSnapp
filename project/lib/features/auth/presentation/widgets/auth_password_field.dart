import 'package:flutter/material.dart';
import 'package:project/core/constants/app_colors.dart';
import 'package:project/core/constants/spacing_constants.dart';
import 'package:project/shared/components/indicators/password_hint.dart';
import 'package:project/shared/components/inputs/custom_text_field.dart';
import 'package:project/shared/components/inputs/form_label.dart';
import 'package:project/core/utils/form_validators.dart';

/// A specialized password input field for authentication screens
class AuthPasswordField extends StatefulWidget {
  /// Controller for the text field
  final TextEditingController controller;

  /// Focus node for the text field
  final FocusNode focusNode;

  /// Called when user submits the field
  final Function(String)? onSubmitted;

  /// Optional callback when field is changed
  final Function(String)? onChanged;

  /// Whether to show password requirement hints
  final bool showHints;

  /// Optional additional validation logic
  final String? Function(String?)? validator;

  /// Constructor
  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.showHints = true,
    this.validator,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool isPasswordFocused = false;
  bool obscureText = true;
  bool showPasswordHints = false;
  late PasswordValidationResult _passwordValidation;

  @override
  void initState() {
    super.initState();

    // Initialize password validation result
    _passwordValidation = PasswordValidationResult(
      hasUppercase: false,
      hasLetter: false,
      hasNumber: false,
      hasMinLength: false,
    );

    // Set up listeners
    widget.controller.addListener(_validatePassword);
    widget.focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    // Clean up listeners to prevent memory leaks
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      isPasswordFocused = widget.focusNode.hasFocus;
      showPasswordHints = widget.showHints && isPasswordFocused;
    });
  }

  void _validatePassword() {
    final password = widget.controller.text;
    setState(() {
      _passwordValidation = FormValidators.validatePassword(password);
    });

    if (widget.onChanged != null) {
      widget.onChanged!(password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isPasswordValid = _passwordValidation.isValid;
    final bool showError =
        widget.controller.text.isNotEmpty && !isPasswordValid;
    final String? errorMessage =
        showError ? 'Please meet all password requirements' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(text: 'Password'),
        const SizedBox(height: SpacingConstants.spacing2),
        CustomTextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          hintText: '••••••••',
          prefixIcon: Icons.lock_outline,
          obscureText: obscureText,
          isValid: isPasswordValid,
          isFocused: isPasswordFocused,
          showError: showError,
          errorText: errorMessage,
          inputBgColor: AppColors.inputBgColor,
          inputBorderColor: AppColors.inputBorderColor,
          inputFocusBorderColor: AppColors.brandColor,
          brandColor: AppColors.brandColor,
          errorColor: AppColors.errorColor,
          suffixIcon: GestureDetector(
            onTapDown: (_) {
              setState(() {
                obscureText = false;
              });
            },
            onTapUp: (_) {
              setState(() {
                obscureText = true;
              });
            },
            onTapCancel: () {
              setState(() {
                obscureText = true;
              });
            },
            excludeFromSemantics: true,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              child: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),
          onSubmitted: widget.onSubmitted,
        ),

        // Password requirement hints
        if (showPasswordHints)
          AnimatedOpacity(
            opacity: showPasswordHints ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.only(top: SpacingConstants.spacing3),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PasswordHint(
                      text: 'uppercase',
                      isValid: _passwordValidation.hasUppercase,
                      fontSize: 12,
                    ),
                    const SizedBox(width: 4),
                    PasswordHint(
                      text: 'letter',
                      isValid: _passwordValidation.hasLetter,
                      fontSize: 12,
                    ),
                    const SizedBox(width: 4),
                    PasswordHint(
                      text: 'number',
                      isValid: _passwordValidation.hasNumber,
                      fontSize: 12,
                    ),
                    const SizedBox(width: 4),
                    PasswordHint(
                      text: '8~20 words',
                      isValid: _passwordValidation.hasMinLength,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
