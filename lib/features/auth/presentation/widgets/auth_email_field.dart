import 'package:flutter/material.dart';
import 'package:project/shared/components/inputs/custom_text_field.dart';
import 'package:project/shared/components/inputs/form_label.dart';
import 'package:project/core/constants/app_colors.dart';
import 'package:project/core/constants/spacing_constants.dart';
import 'package:project/core/utils/form_validators.dart';
import 'package:project/features/auth/presentation/theme/welcome_page_styles.dart';

/// A specialized email input field for authentication screens
class AuthEmailField extends StatefulWidget {
  /// Controller for the text field
  final TextEditingController controller;

  /// Focus node for the text field
  final FocusNode focusNode;

  /// Called when user submits the field
  final Function(String)? onSubmitted;

  /// Optional callback when field is changed
  final Function(String)? onChanged;

  /// Optional additional validation logic
  final String? Function(String?)? validator;

  /// Constructor
  const AuthEmailField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.validator,
  });

  @override
  State<AuthEmailField> createState() => _AuthEmailFieldState();
}

class _AuthEmailFieldState extends State<AuthEmailField> {
  bool isEmailFocused = false;
  bool isEmailValid = false;

  @override
  void initState() {
    super.initState();

    // Set up listeners
    widget.controller.addListener(_validateEmail);
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
      isEmailFocused = widget.focusNode.hasFocus;
    });
  }

  void _validateEmail() {
    setState(() {
      isEmailValid = FormValidators.validateEmail(widget.controller.text);
    });

    if (widget.onChanged != null) {
      widget.onChanged!(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final showError = widget.controller.text.isNotEmpty && !isEmailValid;
    final String? errorMessage =
        showError ? 'Please enter a valid email' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(text: 'Email'),
        const SizedBox(height: SpacingConstants.spacing2),
        CustomTextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          hintText: 'yourname@example.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          isValid: isEmailValid,
          isFocused: isEmailFocused,
          showError: showError,
          errorText: errorMessage,
          inputBgColor: AppColors.inputBgColor,
          inputBorderColor: AppColors.inputBorderColor,
          inputFocusBorderColor: WelcomePageStyles.brandColor,
          brandColor: WelcomePageStyles.brandColor,
          errorColor: AppColors.errorColor,
          onSubmitted: widget.onSubmitted,
        ),
      ],
    );
  }
}
