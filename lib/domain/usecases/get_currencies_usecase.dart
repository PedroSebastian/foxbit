import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_client/data/helpers/websocket.dart';
import 'package:foxbit_client/domain/entities/currency.dart';
import 'package:foxbit_client/domain/repositories/currencies_repository.dart';
import 'package:foxbit_client/domain/repositories/quotes_repository.dart';

class GetCurrenciesUseCase extends CompletableUseCase<FoxbitWebSocket> {
  final ICurrenciesRepository _currenciesRepository;
  final IQuotesRepository _quotesRepository;

  GetCurrenciesUseCase(this._currenciesRepository, this._quotesRepository);

  @override
  Future<Stream<List<Currency>>> buildUseCaseStream(FoxbitWebSocket params) async {
    final StreamController<List<Currency>> streamController =
        StreamController<List<Currency>>();

    try {
      final List<Currency> currencies =
          await _currenciesRepository.getCurrencyRealPairs();

      final List<Currency> currenciesWithQuotes = [];

      for (final Currency currency in currencies) {
        currenciesWithQuotes.add(await _quotesRepository.getFirstQuoteBy(currency));
      }

      streamController.add(currenciesWithQuotes);
      streamController.close();
    } catch (exception) {
      streamController.addError(exception);
    }

    return streamController.stream;
  }
}
