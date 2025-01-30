import 'package:flutter/material.dart';
import 'package:round_1/core/text_styles.dart';
import 'package:round_1/widgets/ui/custom_input.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.label,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double min;
  final double max;
  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyTextMedium),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${min.toStringAsFixed(0)}',
                  style: AppTextStyles.bodyTextSmall,
                ),
                Text(
                  '\$${max.toStringAsFixed(0)}',
                  style: AppTextStyles.bodyTextSmall,
                )
              ],
            ),
            Slider(
              value: value < min ? min : value,
              min: min,
              max: max,
              divisions: 10,
              activeColor: Colors.blue,
              thumbColor: Colors.blue,
              label: "\$${(value).toStringAsFixed(2)}",
              onChanged: (double newValue) =>
                  onChanged(double.parse(newValue.toStringAsFixed(2))),
            ),
          ],
        ),
      ],
    );
  }
}
