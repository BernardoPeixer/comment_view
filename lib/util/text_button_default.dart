import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonDefault extends StatelessWidget {
  const TextButtonDefault({
    super.key,
    required this.text,
    required this.onPressed,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: style ??
            GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xffbfbbbb),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
      ),
    );
  }
}
