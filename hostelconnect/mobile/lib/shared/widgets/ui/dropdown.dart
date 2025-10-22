// lib/shared/widgets/ui/dropdown.dart
import 'package:flutter/material.dart';
import '../../theme/telugu_theme.dart';

class HDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;

  const HDropdown({
    super.key,
    this.label,
    this.hintText,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: HTeluguTheme.body2.copyWith(
              fontWeight: FontWeight.w600,
              color: HTeluguTheme.textPrimary,
            ),
          ),
          const SizedBox(height: HTeluguTheme.spacingSM),
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          style: HTeluguTheme.body1.copyWith(
            color: HTeluguTheme.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: HTeluguTheme.body1.copyWith(
              color: HTeluguTheme.textSecondary,
            ),
            filled: true,
            fillColor: enabled ? HTeluguTheme.surface : HTeluguTheme.surface.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
              borderSide: BorderSide(
                color: HTeluguTheme.border,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
              borderSide: BorderSide(
                color: HTeluguTheme.border,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
              borderSide: BorderSide(
                color: HTeluguTheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
              borderSide: BorderSide(
                color: HTeluguTheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
              borderSide: BorderSide(
                color: HTeluguTheme.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTeluguTheme.radiusMD),
              borderSide: BorderSide(
                color: HTeluguTheme.border.withOpacity(0.5),
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: HTeluguTheme.spacingMD,
              vertical: HTeluguTheme.spacingSM,
            ),
          ),
        ),
      ],
    );
  }
}
