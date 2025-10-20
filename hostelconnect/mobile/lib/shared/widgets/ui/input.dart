// lib/shared/widgets/ui/input.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/responsive.dart';

class HInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? error;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final bool autofocus;

  const HInput({
    super.key,
    this.label,
    this.hint,
    this.error,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
  });

  @override
  State<HInput> createState() => _HInputState();
}

class _HInputState extends State<HInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
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
    return HResponsive.builder(builder: (ctx, r) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: TextStyle(
                fontSize: r.isXS ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: HTokens.onSurface,
              ),
            ),
            SizedBox(height: HTokens.sm),
          ],
          TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            autofocus: widget.autofocus,
            style: TextStyle(
              fontSize: r.isXS ? 14 : 16,
              color: HTokens.onSurface,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: HTokens.onSurfaceVariant,
                fontSize: r.isXS ? 14 : 16,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              errorText: widget.error,
              filled: true,
              fillColor: widget.enabled ? HTokens.surface : HTokens.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HTokens.cardRadius),
                borderSide: BorderSide(color: HTokens.onSurfaceVariant.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HTokens.cardRadius),
                borderSide: BorderSide(color: HTokens.onSurfaceVariant.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HTokens.cardRadius),
                borderSide: BorderSide(color: HTokens.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HTokens.cardRadius),
                borderSide: BorderSide(color: HTokens.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HTokens.cardRadius),
                borderSide: BorderSide(color: HTokens.error, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: HTokens.lg,
                vertical: HTokens.md,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class HSearchInput extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;

  const HSearchInput({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return HInput(
        controller: controller,
        hint: hint ?? 'Search...',
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        prefixIcon: Icon(
          Icons.search,
          color: HTokens.onSurfaceVariant,
          size: r.isXS ? 18 : 20,
        ),
        suffixIcon: controller?.text.isNotEmpty == true
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: HTokens.onSurfaceVariant,
                  size: r.isXS ? 18 : 20,
                ),
                onPressed: onClear,
              )
            : null,
      );
    });
  }
}
