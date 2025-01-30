import 'package:flutter/material.dart';
import 'package:round_1/core/text_styles.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  final String label;
  final List<String> options;
  final String selectedValue;
  final Function(String) onChanged;

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 40,
      children: [
        Text(label, style: AppTextStyles.bodyTextSmall),
        Wrap(
          spacing: 20,
          children: options.map((String option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  activeColor: Colors.blue,
                  value: option,
                  groupValue: selectedValue,
                  onChanged: (String? value) {
                    if (value != null) {
                      onChanged(value);
                    }
                  },
                ),
                Text(capitalizeFirstLetter(option),
                    style: AppTextStyles.bodyTextSmall.copyWith(
                      color:
                          selectedValue == option ? Colors.blue : Colors.black,
                    )),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
