import 'package:foxbit_client/data/helpers/websocket.dart';
import 'package:foxbit_client/domain/entities/currency.dart';
import 'package:foxbit_client/domain/entities/quote.dart';
import 'package:foxbit_client/domain/repositories/quotes_repository.dart';

class QuotesRepository implements IQuotesRepository {
  final String _eventChannel = 'SubscribeLevel1';
  final FoxbitWebSocket webSocket;

  QuotesRepository(this.webSocket);

  @override
  Future<Currency> getFirstQuoteBy(Currency currency) async {
    return getQuoteBy(currency).first;
  }

  @override
  Stream<Currency> getQuoteBy(Currency currency) {
    webSocket.send(_eventChannel, {'InstrumentId': currency.instrumentId});

    return webSocket.stream
        .where((event) => event['n'].toString() == _eventChannel)
        .where((event) => event['o']['InstrumentId'] == currency.instrumentId)
        .map((Map event) => Quote.fromMap(event['o'] as Map))
        .map((event) => currency.copyWith(quote: event));
  }
}
