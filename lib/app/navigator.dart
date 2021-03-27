import 'package:flutter/material.dart';
import 'package:foxbit_client/app/pages/currencies/currencies_view.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (BuildContext context) => CurrenciesPage(),
};
