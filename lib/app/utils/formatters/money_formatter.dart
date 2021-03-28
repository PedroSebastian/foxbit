import 'package:flutter_money_formatter/flutter_money_formatter.dart';

String formatBRLMoneyValue(double value) {
  final FlutterMoneyFormatter moneyFormatter = FlutterMoneyFormatter(
      amount: value,
      settings: MoneyFormatterSettings(
          symbol: 'R\$',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2));

  return moneyFormatter.output.symbolOnLeft;
}
