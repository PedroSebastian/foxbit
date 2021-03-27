import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foxbit_client/app/navigator.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    enterInApp();
    super.initState();
  }

  Future<void> enterInApp() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacementNamed(RouteNames.currenciesPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: FadeInUp(
                      child: SvgPicture.asset('assets/images/branding.svg'))),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
