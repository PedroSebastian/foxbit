import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_client/app/utils/formatters/money_formatter.dart';
import 'package:foxbit_client/app/utils/metrics/app_metrics.dart';
import 'package:foxbit_client/app/utils/styles/foxbit_colors.dart';
import 'package:foxbit_client/app/widgets/app_circular_indicator.dart';
import 'package:foxbit_client/app/widgets/currency_item.dart';
import 'package:foxbit_client/app/widgets/custom_app_bar.dart';

import 'currencies_controller.dart';

class CurrenciesPage extends View {
  @override
  State<StatefulWidget> createState() => CurrenciesPageState();
}

class CurrenciesPageState
    extends ViewState<CurrenciesPage, CurrenciesController> {
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

            if (controller.hasError) {
              return buildErrorSection(controller);
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
                        imageAsset:
                            'assets/images/${currency.instrumentId}.png',
                      ),
                      SizedBox(height: AppMetrics.getDefaultSpacing())
                    ],
                  ),
              ],
            );
          }),
        ),
      );

  Center buildErrorSection(CurrenciesController controller) {
    return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 35, color: FoxBitColors.blackColor),
                  SizedBox(height: AppMetrics.getDefaultSpacingWithMultiplier(3)),
                  const Text('Oops, erro ao \ncarregar as cotações.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300)),
                  SizedBox(height: AppMetrics.getDefaultSpacing()),
                  CupertinoButton(
                      onPressed: controller.retry,
                      child: const Text('Tentar novamente')),
                  SizedBox(height: AppMetrics.getDefaultSpacingWithMultiplier(3))
                ],
              ),
            );
  }
}
