import 'package:flutter/material.dart';

class CustomElevated extends StatelessWidget {
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback onPress;
  final String title;
  final Color textColor;
  final String fontFamily;
  final FontWeight fontWeight;
  final double elevation;

  CustomElevated({
    Key? key,
    required this.backgroundColor,
    required this.borderRadius,
    required this.onPress,
    required this.title,
    required this.textColor,
    required this.fontFamily,
    required this.fontWeight,
    required this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
        elevation: WidgetStateProperty.all<double>(10.0),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
