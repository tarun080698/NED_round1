import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:round_1/core/text_styles.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.type = TextInputType.number,
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  final TextInputType type;
  final String label;
  final String hint;
  final String value;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isNotEmpty
            ? Text(label, style: AppTextStyles.bodyTextSmall)
            : const SizedBox.shrink(),
        label.isNotEmpty ? const SizedBox(height: 8) : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            inputFormatters: type == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            keyboardType: type,
            cursorColor: Colors.blue,
            autofocus: true,
            initialValue: value,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              prefixText: type == TextInputType.number ? "\$ " : "",
              prefixStyle:
                  AppTextStyles.bodyTextSmall.copyWith(color: Colors.black54),
            ),
            onChanged: onChanged,
            style: AppTextStyles.bodyTextSmall,
          ),
        ),
      ],
    );
  }
}
