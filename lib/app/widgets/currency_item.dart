import 'package:flutter/material.dart';
import 'package:foxbit_client/app/utils/metrics/app_metrics.dart';
import 'package:foxbit_client/app/utils/styles/foxbit_colors.dart';

class CurrencyItem extends StatelessWidget {
  final String currencyName;
  final String tickerSymbol;
  final String price;
  final double variation;
  final String imageAsset;

  const CurrencyItem({
    Key key,
    this.currencyName,
    this.tickerSymbol,
    this.price,
    this.variation,
    this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: FoxBitColors.whiteColor,
      child: Padding(
          padding: EdgeInsets.all(AppMetrics.getDefaultSpacing()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 18,
                    child: Image.asset(imageAsset),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currencyName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(tickerSymbol,
                          style: const TextStyle(
                              color: FoxBitColors.grayColor, fontSize: 12)),
                    ],
                  )
                ],
              ),
              Text(variation.toString(),
                  style: TextStyle(
                      color: variation < 0
                          ? FoxBitColors.redColor
                          : FoxBitColors.greenColor,
                      fontSize: 14)),
              Text(price,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
            ],
          )),
    );
  }
}
