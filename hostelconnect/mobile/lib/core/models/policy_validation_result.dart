// lib/core/models/policy_validation_result.dart

/// Model for policy validation results
class PolicyValidationResult {
  final bool isValid;
  final List<PolicyValidationError> errors;
  final List<PolicyValidationWarning> warnings;
  final Map<String, dynamic>? suggestions;
  final DateTime validatedAt;

  const PolicyValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
    this.suggestions,
    required this.validatedAt,
  });

  Map<String, dynamic> toJson() => {
    'isValid': isValid,
    'errors': errors.map((e) => e.toJson()).toList(),
    'warnings': warnings.map((w) => w.toJson()).toList(),
    if (suggestions != null) 'suggestions': suggestions,
    'validatedAt': validatedAt.toIso8601String(),
  };

  factory PolicyValidationResult.fromJson(Map<String, dynamic> json) {
    return PolicyValidationResult(
      isValid: json['isValid'] as bool,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => PolicyValidationError.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((w) => PolicyValidationWarning.fromJson(w as Map<String, dynamic>))
          .toList(),
      suggestions: json['suggestions'] != null
          ? Map<String, dynamic>.from(json['suggestions'] as Map)
          : null,
      validatedAt: DateTime.parse(json['validatedAt'] as String),
    );
  }
}

class PolicyValidationError {
  final String field;
  final String message;
  final String code;
  final String severity; // 'CRITICAL', 'HIGH', 'MEDIUM'

  const PolicyValidationError({
    required this.field,
    required this.message,
    required this.code,
    required this.severity,
  });

  Map<String, dynamic> toJson() => {
    'field': field,
    'message': message,
    'code': code,
    'severity': severity,
  };

  factory PolicyValidationError.fromJson(Map<String, dynamic> json) {
    return PolicyValidationError(
      field: json['field'] as String,
      message: json['message'] as String,
      code: json['code'] as String,
      severity: json['severity'] as String,
    );
  }
}

class PolicyValidationWarning {
  final String field;
  final String message;
  final String? recommendation;

  const PolicyValidationWarning({
    required this.field,
    required this.message,
    this.recommendation,
  });

  Map<String, dynamic> toJson() => {
    'field': field,
    'message': message,
    if (recommendation != null) 'recommendation': recommendation,
  };

  factory PolicyValidationWarning.fromJson(Map<String, dynamic> json) {
    return PolicyValidationWarning(
      field: json['field'] as String,
      message: json['message'] as String,
      recommendation: json['recommendation'] as String?,
    );
  }
}
