import 'package:flutter/material.dart';
import 'package:round_1/core/models/UI_form_config.dart';
import 'package:round_1/core/models/use_of_funds_field_model.dart';
import 'package:round_1/core/text_styles.dart';
import 'package:round_1/widgets/funding_row.dart';
import 'package:round_1/widgets/ui/custom_dropdown.dart';
import 'package:round_1/widgets/ui/custom_input.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:http/http.dart' as http;
import 'package:round_1/widgets/ui/custom_radio.dart';
import 'dart:convert';

import 'package:round_1/widgets/ui/custom_slider.dart';

class FinanceForm extends StatefulWidget {
  const FinanceForm(
      {super.key, required this.updateResults, required this.results});

  final Function(String, dynamic) updateResults;
  final Map<String, dynamic> results;

  @override
  _FinanceFormState createState() => _FinanceFormState();
}

class _FinanceFormState extends State<FinanceForm> {
  late FormModel formFieldsConfig = FormModel.fromList([]);
  bool isLoading = true;
  String formula = "(0.156 / 6.2055 / revenue_amount) * (funding_amount * 10)";

  String _type = 'Marketing';
  String _description = "Promote the brand";
  double _amount = 1000;

  final List<UseOfFundsFormFields> useOfFunds = [];

  double getTotalAmount() {
    return _amount + useOfFunds.fold(0, (sum, item) => sum + item.amount);
  }

  void removeItem(int index) {
    setState(() {
      useOfFunds.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUIConfig();
  }

  Future<void> fetchUIConfig() async {
    final url = Uri.parse(
        'https://gist.githubusercontent.com/motgi/8fc373cbfccee534c820875ba20ae7b5/raw/7143758ff2caa773e651dc3576de57cc829339c0/config.json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        formFieldsConfig = FormModel.fromList(json.decode(response.body));

        recompute('desired_fee_percentage',
            double.parse(formFieldsConfig.desired_fee_percentage.value));
        widget.updateResults('fees_percentage', computeFormula());
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load UI configuration');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  void recompute(key, dynamic value) {
    widget.updateResults(key, value);
  }

  void handleFundingAmount(value) {
    if (value.toString().isEmpty ||
        double.parse(value) <=
            double.parse(formFieldsConfig.funding_amount_min.value)) {
      widget.updateResults('funding_amount',
          double.parse(formFieldsConfig.funding_amount_min.value));
    } else if (double.parse(value) >=
        double.parse(formFieldsConfig.funding_amount_max.value)) {
      widget.updateResults('funding_amount',
          double.parse(formFieldsConfig.funding_amount_max.value));
    } else {
      widget.updateResults('funding_amount', double.parse(value));
    }
    widget.updateResults('fees_percentage', computeFormula());
  }

  void handleRevenueChange(value) {
    if (value == "" ||
        (value / 3) < double.parse(formFieldsConfig.funding_amount_min.value)) {
      widget.updateResults('funding_amount',
          double.parse(formFieldsConfig.funding_amount_min.value));
      widget.updateResults('revenue_amount',
          double.parse(formFieldsConfig.funding_amount_min.value));
    } else {
      widget.updateResults('revenue_amount', value);
    }
    widget.updateResults('fees_percentage', computeFormula());
  }

  double computeFormula() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(formula);
      ContextModel cm = ContextModel();
      double revenueAmount = widget.results['revenue_amount'] ?? 0.0;
      double fundingAmount = widget.results['funding_amount'] ?? 0.0;

      cm.bindVariable(Variable('revenue_amount'), Number(revenueAmount));
      cm.bindVariable(Variable('funding_amount'), Number(fundingAmount));

      double rate = exp.evaluate(EvaluationType.REAL, cm);

// bonus
      double minRate =
          double.parse(formFieldsConfig.revenue_percentage_min.value);
      double maxRate =
          double.parse(formFieldsConfig.revenue_percentage_max.value);
      rate = (rate * 100).clamp(minRate, maxRate);

      return rate;
    } catch (e) {
      print("Error in computeFormula: $e");
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double computedValue = computeFormula();

    double minValue = double.parse(formFieldsConfig.funding_amount_min.value);
    double computedMax = widget.results['revenue_amount'] / 3;
    double maxValue =
        (computedMax < double.parse(formFieldsConfig.funding_amount_max.value))
            ? computedMax
            : double.parse(formFieldsConfig.funding_amount_max.value);

    double finalMaxValue = (maxValue >= minValue) ? maxValue : minValue;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 20,
                children: [
                  Text(
                    'Financing Options',
                    style: AppTextStyles.subTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                      label: formFieldsConfig.revenue_amount.label,
                      hint: formFieldsConfig.revenue_amount.placeholder,
                      value: widget.results['revenue_amount'].toString(),
                      onChanged: (value) {
                        handleRevenueChange(value);
                      }),
                  Wrap(alignment: WrapAlignment.spaceBetween, children: [
                    Text(
                      formFieldsConfig.funding_amount.label,
                      style: AppTextStyles.bodyTextSmall,
                    ),
                    SizedBox(
                        width: 630,
                        child: CustomSlider(
                            label: '',
                            min: double.parse(
                                formFieldsConfig.funding_amount_min.value),
                            max: finalMaxValue,
                            value: widget.results['funding_amount'],
                            onChanged: (newValue) =>
                                handleFundingAmount(newValue.toString()))),
                    SizedBox(
                      width: 150,
                      child: CustomInput(
                          label: "",
                          hint: formFieldsConfig.funding_amount_min.value,
                          value: widget.results['funding_amount'].toString(),
                          onChanged: (newValue) =>
                              {handleFundingAmount(newValue)}),
                    )
                  ]),
                  Row(spacing: 20, children: [
                    Text('${formFieldsConfig.revenue_percentage.label}:',
                        style: AppTextStyles.bodyTextSmall),
                    Text('${(computedValue).toStringAsFixed(2)}%',
                        style: AppTextStyles.bodyTextSmall.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.w700)),
                  ]),
                  CustomRadio(
                      label: formFieldsConfig.revenue_shared_frequency.label,
                      options: formFieldsConfig.revenue_shared_frequency.value
                          .split('*'),
                      selectedValue:
                          widget.results['payment_frequency'] ?? 'monthly',
                      onChanged: (value) =>
                          recompute('payment_frequency', value)),
                  CustomDropdown(
                      label: formFieldsConfig.desired_repayment_delay.label,
                      options: formFieldsConfig.desired_repayment_delay.value
                          .split('*'),
                      selectedValue:
                          widget.results['repayment_delay'] ?? '30 days',
                      onChanged: (value) =>
                          recompute('repayment_delay', value)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(formFieldsConfig.use_of_funds.label,
                          style: AppTextStyles.bodyTextSmall),
                      const SizedBox(
                        height: 8,
                      ),
                      FundingRow(
                        options: formFieldsConfig.use_of_funds.value.split('*'),
                        selectedValue: _type,
                        description: _description,
                        amount: _amount.toString(),
                        disableAdd:
                            getTotalAmount() > widget.results['funding_amount'],
                        onDropdownChanged: (String newValue) {
                          setState(() {
                            _type = newValue;
                          });
                        },
                        onDescriptionChanged: (String newValue) {
                          setState(() {
                            _description = newValue;
                          });
                        },
                        onAmountChanged: (String newValue) {
                          setState(() {
                            _amount = double.parse(newValue);
                          });
                        },
                        onAdd: () {
                          setState(() {
                            useOfFunds.add(UseOfFundsFormFields(
                                type: _type,
                                description: _description,
                                amount: _amount));
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 200,
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: useOfFunds.asMap().entries.map(
                                  (entry) {
                                    int index = entry.key;
                                    UseOfFundsFormFields item = entry.value;

                                    return Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(item.type,
                                                style: AppTextStyles
                                                    .bodyTextSmall)),
                                        Expanded(
                                          flex: 3,
                                          child: Text(item.description,
                                              style:
                                                  AppTextStyles.bodyTextSmall),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text('\$${item.amount}',
                                                style: AppTextStyles
                                                    .bodyTextSmall)),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline,
                                              color: Colors.red),
                                          onPressed: () {
                                            removeItem(index);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
