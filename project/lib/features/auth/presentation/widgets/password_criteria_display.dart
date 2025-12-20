import 'package:flutter/material.dart';
import 'package:project/core/utils/form_validators.dart';

/// Visualizes password requirements with live validity state.
class PasswordCriteriaDisplay extends StatelessWidget {
  /// Current validation snapshot for the password field.
  final PasswordValidationResult validationResult;

  const PasswordCriteriaDisplay({
    super.key,
    required this.validationResult,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _CriteriaChip(
          label: 'Uppercase',
          isValid: validationResult.hasUppercase,
        ),
        _CriteriaChip(
          label: 'Letter',
          isValid: validationResult.hasLetter,
        ),
        _CriteriaChip(
          label: 'Number',
          isValid: validationResult.hasNumber,
        ),
        _CriteriaChip(
          label: '8-20 chars',
          isValid: validationResult.hasMinLength,
        ),
      ],
    );
  }
}

class _CriteriaChip extends StatelessWidget {
  final String label;
  final bool isValid;

  const _CriteriaChip({
    required this.label,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final Color validColor = Colors.green.shade600;
    final Color invalidColor = Colors.grey.shade600;
    final Color validBgColor = Colors.green.shade50;
    final Color invalidBgColor = Colors.grey.shade100;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isValid ? validBgColor : invalidBgColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isValid ? validColor.withValues(alpha: 0.6) : Colors.transparent,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isValid ? validColor : invalidColor,
        ),
      ),
    );
  }
}
