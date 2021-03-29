import 'package:flutter_test/flutter_test.dart';
import 'package:foxbit_client/data/repositories/currencies_repository.dart';
import 'package:foxbit_client/domain/entities/currency.dart';

import 'connections/test_websocket.dart';

void main() {
  TestFoxbitWebSocket webSocket;
  CurrenciesRepository repository;

  setUp(() {
    webSocket = TestFoxbitWebSocket();
    repository = CurrenciesRepository(webSocket);
  });

  test('Validate currency list search', () async {
    final List<Currency> result = await repository.getCurrencyRealPairs();

    final List<Currency> expected = [
      Currency.fromMap({'InstrumentId': 1, 'Symbol': 'BTC/BRL', 'SortIndex': 0, 'Product1Symbol': 'BTC'}),
      Currency.fromMap({'InstrumentId': 2, 'Symbol': 'LTC/BRL', 'SortIndex': 0, 'Product1Symbol': 'LTC'})
    ];

    expect(result.length, expected.length);

    for (int index = 0; index < result.length; index++) {
      expect(result[index].toMap(), expected[index].toMap());
      expect(result[index].toMap(), expected[index].toMap());
    }
  });
}