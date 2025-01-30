import 'package:flutter/material.dart';
import 'package:round_1/widgets/ui/custom_button.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 768
              ? MediaQuery.of(context).size.width * 0.95
              : MediaQuery.of(context).size.width * 0.8,
          height: 192,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(onPressed: () {}, text: "Back", type: 'outlined'),
                CustomButton(onPressed: () {}, text: "Next", type: 'filled'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
