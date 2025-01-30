import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.type});
  final Function() onPressed;
  final String text;
  final String type;

  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width * 0.8 * 0.3;

    if (type == 'filled') {
      return FilledButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          minimumSize: Size(btnWidth * 0.7, 70),
          maximumSize: Size(btnWidth, 70),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      );
    }
    if (type == 'outlined') {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          // minimumSize: const Size(150, 70),
          // maximumSize: const Size(512, 70),

          minimumSize: Size(btnWidth * 0.7, 70),
          maximumSize: Size(btnWidth, 70),
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        minimumSize: Size(btnWidth * 0.7, 70),
        maximumSize: Size(btnWidth, 70),
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}
