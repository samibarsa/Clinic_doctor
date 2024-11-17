import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SectionTitle extends StatelessWidget {
  final String title;

  TextStyle? style;
  SectionTitle({super.key, required this.title, this.style});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      // ignore: prefer_if_null_operators
      style: style == null
          ? const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            )
          : style,
    );
  }
}
