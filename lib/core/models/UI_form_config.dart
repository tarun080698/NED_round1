import 'package:round_1/core/models/form_field_config.dart';

class FormModel {
  final FormFieldConfig desired_fee_percentage;
  final FormFieldConfig desired_repayment_delay;
  final FormFieldConfig funding_amount;
  final FormFieldConfig revenue_amount;
  final FormFieldConfig revenue_percentage;
  final FormFieldConfig revenue_shared_frequency;
  final FormFieldConfig use_of_funds;
  final FormFieldConfig funding_amount_max;
  final FormFieldConfig funding_amount_min;
  final FormFieldConfig revenue_percentage_min;
  final FormFieldConfig revenue_percentage_max;

  FormModel({
    required this.desired_fee_percentage,
    required this.desired_repayment_delay,
    required this.funding_amount,
    required this.revenue_amount,
    required this.revenue_percentage,
    required this.revenue_shared_frequency,
    required this.use_of_funds,
    required this.funding_amount_max,
    required this.funding_amount_min,
    required this.revenue_percentage_min,
    required this.revenue_percentage_max,
  });

  /// **Factory constructor that safely initializes missing fields with defaults**
  factory FormModel.fromList(List<dynamic> list) {
    final formFieldConfigs = list
        .map((item) => FormFieldConfig.fromJson(item as Map<String, dynamic>))
        .toList();

    final modelMap = <String, FormFieldConfig>{
      for (var model in formFieldConfigs) model.name: model
    };

    // **Default values for missing fields**
    FormFieldConfig defaultField(String name, String defaultValue) {
      return modelMap[name] ??
          FormFieldConfig(
              name: name,
              value: defaultValue,
              label: "",
              placeholder: "",
              tooltip: '');
    }

    return FormModel(
      desired_fee_percentage: defaultField('desired_fee_percentage', '0'),
      desired_repayment_delay:
          defaultField('desired_repayment_delay', '30 days'),
      funding_amount: defaultField('funding_amount', '25000'),
      revenue_amount: defaultField('revenue_amount', '100000'),
      revenue_percentage: defaultField('revenue_percentage', '5'),
      revenue_shared_frequency:
          defaultField('revenue_shared_frequency', 'monthly'),
      use_of_funds: defaultField('use_of_funds', ''),
      funding_amount_max: defaultField('funding_amount_max', '100000'),
      funding_amount_min: defaultField('funding_amount_min', '25000'),
      revenue_percentage_min: defaultField('revenue_percentage_min', '0'),
      revenue_percentage_max: defaultField('revenue_percentage_max', '100'),
    );
  }
}
