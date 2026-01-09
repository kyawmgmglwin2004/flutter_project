import 'package:flutter/material.dart';
import 'package:ntt/core/theme/app_theme.dart';

class ButtonWidget extends StatelessWidget {
  // const ButtonWidget({super.key});
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppTheme.secondaryColor,
          foregroundColor: color ?? Colors.white
        ),
        onPressed: () {},
        child: Text(text) );
  }

}