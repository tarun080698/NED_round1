import 'package:flutter/material.dart';
import 'package:round_1/widgets/footer.dart';
import 'package:round_1/widgets/header.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen(
      {required this.leftWidget, required this.rightWidget, super.key});
  final Widget leftWidget;
  final Widget rightWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background color
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double contentWidth = screenWidth > 1552 ? 1552 : screenWidth * 0.95;
          double sidePadding = 25;

          return Center(
            child: Container(
              width: contentWidth,
              height: contentWidth < 1024 ? 1500 : 900,
              padding: contentWidth < 1024
                  ? EdgeInsets.all(10)
                  : EdgeInsets.symmetric(
                      horizontal: sidePadding), // ✅ Ensures space on all sides
              child: contentWidth < 1024
                  ? Column(
                      children: [
                        Expanded(
                          child: leftWidget,
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: rightWidget,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: leftWidget,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: rightWidget,
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
