import 'package:flutter_test/flutter_test.dart';
import 'package:foxbit_client/data/repositories/quotes_repository.dart';
import 'package:foxbit_client/domain/entities/currency.dart';
import 'package:foxbit_client/domain/entities/quote.dart';

import 'connections/test_websocket.dart';

void main() {
  TestFoxbitWebSocket webSocket;
  QuotesRepository quotesRepository;

  setUp(() {
    webSocket = TestFoxbitWebSocket();
    quotesRepository = QuotesRepository(webSocket);
  });

  test('Validate quote search', () async {
    final Currency currency = Currency.fromMap({'InstrumentId': 1, 'Symbol': 'BTC/BRL', 'SortIndex': 0, 'Product1Symbol': 'BTC'});

    final Currency result = await quotesRepository.getFirstQuoteBy(currency);
    final Currency expected = currency.copyWith(quote: Quote.fromMap({'LastTradedPx': 20.0, 'Rolling24HrVolume': 0.0005, 'Rolling24HrPxChange': -92.2308}));

    expect(result.toMap(), expected.toMap());
  });
}