import 'package:round_1/core/models/form_field_config.dart';

class FormModel {
  FormFieldConfig desired_fee_percentage;
  FormFieldConfig desired_repayment_delay;
  FormFieldConfig funding_amount;
  FormFieldConfig revenue_amount;
  FormFieldConfig revenue_percentage;
  FormFieldConfig revenue_shared_frequency;
  FormFieldConfig use_of_funds;
  FormFieldConfig funding_amount_max;
  FormFieldConfig funding_amount_min;
  FormFieldConfig revenue_percentage_min;
  FormFieldConfig revenue_percentage_max;

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

  factory FormModel.fromList(List<dynamic> list) {
    // 1) Convert each item in the list to a FormFieldConfig.
    final FormFieldConfigs = list
        .map((item) => FormFieldConfig.fromJson(item as Map<String, dynamic>))
        .toList();

    // 2) Build a map from 'name' -> FormFieldConfig for easy access
    final modelMap = <String, FormFieldConfig>{
      for (var model in FormFieldConfigs) model.name: model
    };

    // 3) Construct the FormModel using the map entries
    return FormModel(
      desired_fee_percentage: modelMap['desired_fee_percentage']!,
      desired_repayment_delay: modelMap['desired_repayment_delay']!,
      funding_amount: modelMap['funding_amount']!,
      revenue_amount: modelMap['revenue_amount']!,
      revenue_percentage: modelMap['revenue_percentage']!,
      revenue_shared_frequency: modelMap['revenue_shared_frequency']!,
      use_of_funds: modelMap['use_of_funds']!,
      funding_amount_max: modelMap['funding_amount_max']!,
      funding_amount_min: modelMap['funding_amount_min']!,
      revenue_percentage_min: modelMap['revenue_percentage_min']!,
      revenue_percentage_max: modelMap['revenue_percentage_max']!,
    );
  }
}
