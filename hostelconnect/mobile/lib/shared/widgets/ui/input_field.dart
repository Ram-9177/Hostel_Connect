// lib/shared/widgets/ui/input_field.dart
import 'package:flutter/material.dart';
import '../../theme/telugu_theme.dart';

class HInputField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final String? initialValue;

  const HInputField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.initialValue,
  });

  @override
  State<HInputField> createState() => _HInputFieldState();
}

class _HInputFieldState extends State<HInputField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: HTeluguTheme.body2.copyWith(
              fontWeight: FontWeight.w600,
              color: HTeluguTheme.textPrimary,
            ),
          ),
          const SizedBox(height: HTokens.xs),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          focusNode: _focusNode,
          style: HTeluguTheme.body1.copyWith(
            color: HTeluguTheme.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: HTeluguTheme.body1.copyWith(
              color: HTeluguTheme.textSecondary,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: HTeluguTheme.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            filled: true,
            fillColor: widget.enabled
                ? (_isFocused ? HTeluguTheme.primary.withOpacity(0.05) : HTeluguTheme.surface)
                : HTeluguTheme.surface.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTokens.sm),
              borderSide: BorderSide(
                color: HTeluguTheme.border,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTokens.sm),
              borderSide: BorderSide(
                color: HTeluguTheme.border,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTokens.sm),
              borderSide: BorderSide(
                color: HTeluguTheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTokens.sm),
              borderSide: BorderSide(
                color: HTeluguTheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTokens.sm),
              borderSide: BorderSide(
                color: HTeluguTheme.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HTokens.sm),
              borderSide: BorderSide(
                color: HTeluguTheme.border.withOpacity(0.5),
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: HTokens.md,
              vertical: HTokens.sm,
            ),
          ),
        ),
      ],
    );
  }
}
