import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double paddingHorizontal;
  final double paddingVertical;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.paddingHorizontal = 0.0, // Default padding (left/right)
    this.paddingVertical = 50.0, // Default padding (top/bottom)
  });

  double _getMaxWidth(double screenWidth) {
    if (screenWidth >= 1536) {
      return 1556; // ✅ 2XL breakpoint (highest max width)
    }
    if (screenWidth >= 1280) return 1280; // ✅ XL breakpoint
    if (screenWidth >= 1024) return 1024; // ✅ LG breakpoint
    if (screenWidth >= 768) return 768; // ✅ MD breakpoint
    return screenWidth *
        0.95; // ✅ Default: 95% of screen width for smaller screens
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = _getMaxWidth(constraints.maxWidth);

        return Center(
          child: Container(
            width: maxWidth, // ✅ Adapts based on screen width
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal, vertical: paddingVertical),
            child: child,
          ),
        );
      },
    );
  }
}
