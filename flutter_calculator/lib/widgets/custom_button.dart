import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color btSecondaryColor;
  final Color btColor;
  final Color btTextColor;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    this.btColor = Colors.black,
    required this.btSecondaryColor,
    this.btTextColor = Colors.white,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: btColor,
            child: Center(
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: btSecondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: btTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
