class UseOfFundsFormFields {
  final String type;
  final String description;
  final double amount;

  // this is a simple model for the list of use of funds displayed at the end of the form

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
