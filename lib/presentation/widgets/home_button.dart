import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const HomeButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.iconColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.75;
    double buttonHeight = screenWidth * 0.15;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: OutlinedButton.icon(
        onPressed: () async {
          await HapticFeedback.selectionClick();
          onPressed();
        },
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
