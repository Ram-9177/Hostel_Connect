import 'package:flutter/material.dart';
import '../../core/responsive.dart';

class HFormValidator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    if (value.length > 50) {
      return 'Password must be less than 50 characters';
    }
    
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }
    
    return null;
  }

  static String? maxLength(String? value, int maxLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (value.length > maxLength) {
      return '${fieldName ?? 'This field'} must be less than $maxLength characters';
    }
    
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  static String? studentId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Student ID is required';
    }
    
    if (value.length < 3) {
      return 'Student ID must be at least 3 characters';
    }
    
    return null;
  }

  static String? roomId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Room ID is required';
    }
    
    return null;
  }

  static String? hostelId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hostel ID is required';
    }
    
    return null;
  }

  static String? name(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Name'} is required';
    }
    
    if (value.length < 2) {
      return '${fieldName ?? 'Name'} must be at least 2 characters';
    }
    
    if (value.length > 50) {
      return '${fieldName ?? 'Name'} must be less than 50 characters';
    }
    
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return '${fieldName ?? 'Name'} can only contain letters and spaces';
    }
    
    return null;
  }
}

class HFormField extends StatefulWidget {
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
  final bool required;
  final String? helperText;

  const HFormField({
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
    this.required = false,
    this.helperText,
  });

  @override
  State<HFormField> createState() => _HFormFieldState();
}

class _HFormFieldState extends State<HFormField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _obscureText = widget.obscureText;
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
            Row(
              children: [
                Text(
                  widget.label!,
                  style: TextStyle(
                    fontSize: r.isXS ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: HTokens.onSurface,
                  ),
                ),
                if (widget.required) ...[
                  SizedBox(width: HTokens.xs),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: r.isXS ? 14 : 16,
                      fontWeight: FontWeight.w500,
                      color: HTokens.error,
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: HTokens.sm),
          ],
          TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            obscureText: _obscureText,
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
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: HTokens.onSurfaceVariant,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
              errorText: widget.error,
              helperText: widget.helperText,
              helperStyle: TextStyle(
                color: HTokens.onSurfaceVariant,
                fontSize: r.isXS ? 12 : 14,
              ),
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

class HFormBuilder extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final List<Widget> children;
  final VoidCallback? onSubmit;
  final String? submitText;
  final bool showSubmitButton;
  final EdgeInsets? padding;

  const HFormBuilder({
    super.key,
    this.formKey,
    required this.children,
    this.onSubmit,
    this.submitText = 'Submit',
    this.showSubmitButton = true,
    this.padding,
  });

  @override
  State<HFormBuilder> createState() => _HFormBuilderState();
}

class _HFormBuilderState extends State<HFormBuilder> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...widget.children,
          if (widget.showSubmitButton) ...[
            SizedBox(height: HTokens.xl),
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: HTokens.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: HTokens.lg),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HTokens.cardRadius),
                ),
              ),
              child: Text(
                widget.submitText!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class HValidationMessage extends StatelessWidget {
  final String message;
  final MessageType type;
  final IconData? icon;
  final VoidCallback? onDismiss;

  const HValidationMessage({
    super.key,
    required this.message,
    this.type = MessageType.info,
    this.icon,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      Color backgroundColor;
      Color textColor;
      IconData defaultIcon;

      switch (type) {
        case MessageType.success:
          backgroundColor = HTokens.success.withOpacity(0.1);
          textColor = HTokens.success;
          defaultIcon = Icons.check_circle;
          break;
        case MessageType.error:
          backgroundColor = HTokens.error.withOpacity(0.1);
          textColor = HTokens.error;
          defaultIcon = Icons.error;
          break;
        case MessageType.warning:
          backgroundColor = HTokens.warning.withOpacity(0.1);
          textColor = HTokens.warning;
          defaultIcon = Icons.warning;
          break;
        case MessageType.info:
          backgroundColor = HTokens.info.withOpacity(0.1);
          textColor = HTokens.info;
          defaultIcon = Icons.info;
          break;
      }

      return Container(
        padding: EdgeInsets.all(HTokens.md),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
          border: Border.all(color: textColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              icon ?? defaultIcon,
              color: textColor,
              size: r.isXS ? 18 : 20,
            ),
            SizedBox(width: HTokens.sm),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: r.isXS ? 12 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onDismiss != null)
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: textColor,
                  size: r.isXS ? 16 : 18,
                ),
                onPressed: onDismiss,
              ),
          ],
        ),
      );
    });
  }
}

enum MessageType {
  success,
  error,
  warning,
  info,
}
