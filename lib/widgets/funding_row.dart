import 'package:flutter/material.dart';
import 'package:round_1/widgets/ui/custom_dropdown.dart';
import 'package:round_1/widgets/ui/custom_input.dart';

class FundingRow extends StatelessWidget {
  const FundingRow({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.description,
    required this.amount,
    required this.onDropdownChanged,
    required this.onDescriptionChanged,
    required this.onAmountChanged,
    required this.onAdd,
    required this.disableAdd,
  });

  final List<String> options;
  final String selectedValue;
  final String description;
  final String amount;
  final bool disableAdd;
  final Function(String) onDropdownChanged;
  final Function(String) onDescriptionChanged;
  final Function(String) onAmountChanged;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      // mainAxisAlignment: M/ainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        Expanded(
          flex: 2,
          child: CustomDropdown(
            label: "",
            options: options,
            selectedValue: selectedValue,
            onChanged: onDropdownChanged,
          ),
        ),
        Expanded(
          flex: 3,
          child: CustomInput(
            type: TextInputType.text,
            label: "",
            hint: "Description",
            value: description,
            onChanged: onDescriptionChanged,
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomInput(
            type: TextInputType.number,
            label: "",
            hint: "Amount",
            value: amount,
            onChanged: onAmountChanged,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline,
              color: disableAdd ? Colors.grey : Colors.blue),
          onPressed: () {
            if (!disableAdd) {
              onAdd();
            }
          },
        ),
      ],
    );
  }
}
