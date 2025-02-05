import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:round_1/core/text_styles.dart';

class CustomInput extends StatefulWidget {
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
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant CustomInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && _controller.text != widget.value) {
      _controller.text = widget.value; // Update controller when value changes
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(widget.label, style: AppTextStyles.bodyTextSmall),
          ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          child: TextFormField(
            controller: _controller, // Use controller instead of initialValue
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter some text';
            //   }
            //   return null;
            // },
            inputFormatters: widget.type == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            keyboardType: widget.type,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: widget.hint,
              border: InputBorder.none,
              prefixText: widget.type == TextInputType.number ? "\$ " : "",
              prefixStyle:
                  AppTextStyles.bodyTextSmall.copyWith(color: Colors.black54),
            ),
            onChanged: (value) {
              widget.onChanged(value.trim().isEmpty ? "" : value);
            },
            style: AppTextStyles.bodyTextSmall,
          ),
        ),
      ],
    );
  }
}
