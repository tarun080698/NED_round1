class UseOfFundsFormFields {
  final String type;
  final String description;
  final double amount;

  UseOfFundsFormFields({
    required this.type,
    required this.description,
    required this.amount,
  });

  factory UseOfFundsFormFields.fromJson(Map<String, dynamic> json) {
    return UseOfFundsFormFields(
      type: json['type'] ?? "",
      description: json['description'] ?? "",
      amount: json['amount'] ?? 0.0,
    );
  }
}
