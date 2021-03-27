import 'package:foxbit_client/domain/entities/currency.dart';

abstract class ICurrenciesRepository {
  Future<List<Currency>> getCurrencyRealPairs();
}