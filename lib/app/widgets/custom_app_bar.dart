import 'package:flutter/material.dart';
import 'package:foxbit_client/app/utils/metrics/app_metrics.dart';
import 'package:foxbit_client/app/utils/styles/foxbit_colors.dart';
import 'package:foxbit_client/app/widgets/header.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget icon;
  final List<Widget> actons;

  const CustomAppBar({
    Key key,
    this.title,
    this.icon,
    this.actons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Header(
        text: title,
        textColor: FoxBitColors.blackColor,
      ),
      backgroundColor: FoxBitColors.whiteColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppMetrics.appBarHeight);
}