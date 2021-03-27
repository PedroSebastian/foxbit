import 'package:foxbit_client/domain/entities/currency.dart';

abstract class IQuotesRepository {
  Future<Currency> getFirstQuoteBy(Currency currency);
  Stream<Currency> getQuoteBy(Currency currency);
}