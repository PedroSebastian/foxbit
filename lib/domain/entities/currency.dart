import 'package:foxbit_client/domain/entities/currency_name_dictionary.dart';
import 'package:foxbit_client/domain/entities/quote.dart';

class Currency {
  final int instrumentId;
  final String symbol;
  final String name;
  final int sortIndex;
  final String productSymbol;
  final Quote quote;

  Currency(
      {this.instrumentId,
      this.symbol,
      this.sortIndex,
      this.productSymbol,
      this.quote,
      this.name});

  factory Currency.fromMap(Map<dynamic, dynamic> map) {
    return Currency(
      instrumentId: map['InstrumentId'] as int,
      symbol: map['Symbol'].toString(),
      sortIndex: map['SortIndex'] as int,
      productSymbol: map['Product1Symbol'].toString(),
      name: getCurrencyName(map['Product1Symbol'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'InstrumentId': instrumentId,
      'Symbol': symbol,
      'SortIndex': sortIndex,
      'Product1Symbol': productSymbol,
      'Name': name,
      'Quote': quote?.toMap() ?? ''
    };
  }

  Currency copyWith(
      {int instrumentId,
      String symbol,
      int sortIndex,
      String product1Symbol,
      String name,
      Quote quote}) {
    return Currency(
        instrumentId: instrumentId ?? this.instrumentId,
        symbol: symbol ?? this.symbol,
        sortIndex: sortIndex ?? this.sortIndex,
        productSymbol: product1Symbol ?? productSymbol,
        name: name ?? this.name,
        quote: quote ?? quote);
  }
}
