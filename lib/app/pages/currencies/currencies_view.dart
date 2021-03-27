import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_client/app/utils/formatters/money_formatter.dart';
import 'package:foxbit_client/app/utils/metrics/app_metrics.dart';
import 'package:foxbit_client/app/widgets/app_circular_indicator.dart';
import 'package:foxbit_client/app/widgets/currency_item.dart';
import 'package:foxbit_client/app/widgets/custom_app_bar.dart';

import 'currencies_controller.dart';

class CurrenciesPage extends View {
  @override
  State<StatefulWidget> createState() => CurrenciesPageState();
}

class CurrenciesPageState extends ViewState<CurrenciesPage, CurrenciesController> {
  CurrenciesPageState() : super(CurrenciesController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        appBar: const CustomAppBar(
          title: 'Cotações',
        ),
        body: SafeArea(
          child: ControlledWidgetBuilder<CurrenciesController>(
            builder: (context, controller) {
              if (controller.isLoading) {
                return const Center(child: AppCircularIndicator());
              }

              return ListView(
                padding: EdgeInsets.all(AppMetrics.getDefaultSpacing()),
                children: [
                  for (final currency in controller.currencies)
                    Column(
                      children: [
                        CurrencyItem(
                          currencyName: currency.name ?? currency.productSymbol,
                          tickerSymbol: currency.productSymbol,
                          price: formatBRLMoneyValue(currency.quote.lastTradedPx),
                          variation: currency.quote.rolling24HrPxChange,
                          imageAsset: 'assets/images/${currency.instrumentId}.png',
                        ),
                        SizedBox(height: AppMetrics.getDefaultSpacing())
                      ],
                    ),
                ],
              );
            }
          ),
        ),
      );
}
