import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  final Color textColor;

  const Header({
    Key key,
    this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            .copyWith(color: textColor ?? Colors.white));
  }
}
