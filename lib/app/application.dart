import 'package:flutter/material.dart';
import 'package:foxbit_client/app/navigator.dart';
import 'package:foxbit_client/app/utils/styles/foxbit_colors.dart';

class FoxbitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foxbit Client',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: FoxBitColors.primaryColor
      ),
      routes: appRoutes,
    );
  }
}