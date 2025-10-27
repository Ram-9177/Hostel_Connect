class GatePassRequest {
  final String reason;
  final DateTime fromDate;
  final DateTime toDate;
  final String? destination;
  final String? guardianContact;
  
  GatePassRequest({
    required this.reason,
    required this.fromDate,
    required this.toDate,
    this.destination,
    this.guardianContact,
  });
  
  Map<String, dynamic> toJson() => {
    'reason': reason,
    'from_date': fromDate.toIso8601String(),
    'to_date': toDate.toIso8601String(),
    if (destination != null) 'destination': destination,
    if (guardianContact != null) 'guardian_contact': guardianContact,
  };
  
  factory GatePassRequest.fromJson(Map<String, dynamic> json) {
    return GatePassRequest(
      reason: json['reason'] as String,
      fromDate: DateTime.parse(json['from_date'] as String),
      toDate: DateTime.parse(json['to_date'] as String),
      destination: json['destination'] as String?,
      guardianContact: json['guardian_contact'] as String?,
    );
  }
}
