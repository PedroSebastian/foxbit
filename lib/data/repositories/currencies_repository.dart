import 'package:foxbit_client/data/helpers/websocket.dart';
import 'package:foxbit_client/domain/entities/currency.dart';
import 'package:foxbit_client/domain/repositories/currencies_repository.dart';

class CurrenciesRepository implements ICurrenciesRepository {
  final String _eventChannel = 'getInstruments';
  final FoxbitWebSocket webSocket;

  CurrenciesRepository(this.webSocket);

  @override
  Future<List<Currency>> getCurrencyRealPairs() async {
    webSocket.send(_eventChannel, {});

    return webSocket.stream
        .where((element) => element['n'].toString() == _eventChannel)
        .map((event) => event['o'] as List)
        .map((event) => event
            .where((e) => e['SessionStatus'] == 'Running')
            .skipWhile((element) => (element['Product2Symbol']) != 'BRL')
            .map((e) => Currency.fromMap(e as Map<String, dynamic>))
            .toList()).first;
  }
}
