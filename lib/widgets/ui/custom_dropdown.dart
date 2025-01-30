import 'package:flutter/material.dart';
import 'package:round_1/core/text_styles.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.label = "",
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  final String label;
  final List<String> options;
  final String selectedValue;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        label.isNotEmpty
            ? Text(label, style: AppTextStyles.bodyTextSmall)
            : const SizedBox.shrink(),
        label.isNotEmpty ? const SizedBox(width: 16) : const SizedBox.shrink(),
        SizedBox(
          width: 150,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                icon: const Icon(Icons.expand_more, color: Colors.grey),
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      style: AppTextStyles.bodyTextSmall.copyWith(
                        color: selectedValue == option
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:round_1/core/text_styles.dart';

// class CustomDropdown extends StatelessWidget {
//   const CustomDropdown({
//     super.key,
//     this.label = "",
//     required this.options,
//     required this.selectedValue,
//     required this.onChanged,
//   });

//   final String label;
//   final List<String> options;
//   final String selectedValue;
//   final Function(String) onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         if (label.isNotEmpty) Text(label, style: AppTextStyles.bodyTextMedium),
//         if (label.isNotEmpty) const SizedBox(width: 16),
//         IntrinsicWidth(
//           // ✅ Makes the width adapt to content
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 value: selectedValue,
//                 icon: const Icon(Icons.expand_more, color: Colors.grey),
//                 items: options.map((String option) {
//                   return DropdownMenuItem<String>(
//                     value: option,
//                     child: Text(
//                       option,
//                       style: AppTextStyles.bodyTextMedium.copyWith(
//                         color: selectedValue == option
//                             ? Colors.blue
//                             : Colors.black,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (String? value) {
//                   if (value != null) {
//                     onChanged(value);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
