import 'package:flutter/material.dart';

class AppCircularIndicator extends StatelessWidget{
  final Color valueColor;
  final Color backgroundColor;

  const AppCircularIndicator({Key key, this.valueColor, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(valueColor ?? Theme.of(context).primaryColor),
            backgroundColor: backgroundColor ?? Colors.white70,
          ),
        ),
      );
  }
}