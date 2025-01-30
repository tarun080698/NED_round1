class FormFieldConfig {
  final String name;
  final String value;
  final String label;
  final String placeholder;
  final String tooltip;

  FormFieldConfig({
    required this.name,
    required this.value,
    required this.label,
    required this.placeholder,
    required this.tooltip,
  });

  factory FormFieldConfig.fromJson(Map<String, dynamic> json) {
    return FormFieldConfig(
      name: json['name'] ?? "",
      value: json['value'] ?? "",
      label: json['label'] ?? "",
      placeholder: json['placeholder'] ?? "",
      tooltip: json['tooltip'] ?? "",
    );
  }
}
