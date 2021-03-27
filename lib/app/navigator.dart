import 'package:flutter/material.dart';
import 'package:foxbit_client/app/pages/currencies/currencies_view.dart';
import 'package:foxbit_client/app/pages/initial/initial_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  RouteNames.initialPage: (BuildContext context) => InitialPage(),
  RouteNames.currenciesPage: (BuildContext context) => CurrenciesPage(),
};

class RouteNames {
  static const initialPage = 'initial';
  static const currenciesPage = 'currencies';
}
