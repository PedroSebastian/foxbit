import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_client/data/helpers/websocket.dart';
import 'package:foxbit_client/data/repositories/currencies_repository.dart';
import 'package:foxbit_client/data/repositories/heartbeat_repository.dart';
import 'package:foxbit_client/data/repositories/quotes_repository.dart';
import 'package:foxbit_client/domain/entities/currency.dart';
import 'package:foxbit_client/domain/usecases/get_currencies_usecase.dart';
import 'package:foxbit_client/domain/usecases/heartbeat_usecase.dart';

class CurrenciesPresenter extends Presenter {

  Function heartbeatOnComplete;
  Function(dynamic) heartbeatOnError;

  final HeartbeatUseCase _heartbeatUseCase = HeartbeatUseCase(HeartbeatRepository());
  
  void Function() onCurrenciesComplete;
  void Function(dynamic) onCurrenciesError;
  void Function(List<Currency>) onNextCurrencies;

  GetCurrenciesUseCase _currenciesUseCase;

  final FoxbitWebSocket webSocket;

  CurrenciesPresenter(this.webSocket) {
    _currenciesUseCase = GetCurrenciesUseCase(
        CurrenciesRepository(webSocket), QuotesRepository(webSocket));
  }

  void sendHeartbeat(FoxbitWebSocket webSocket) {
    _heartbeatUseCase.execute(_HeartBeatObserver(this), webSocket);
  }

  void getCurrencies() {
    _currenciesUseCase.execute(_CurrenciesObserver(this), webSocket);
  }

  @override
  void dispose() {
    _heartbeatUseCase.dispose();
    _currenciesUseCase.dispose();
  }
}

class _HeartBeatObserver implements Observer<void> {
  CurrenciesPresenter presenter;

  _HeartBeatObserver(this.presenter);

  @override
  void onNext(_) {}

  @override
  void onComplete() {
    assert(presenter.heartbeatOnComplete != null);
    presenter.heartbeatOnComplete();
  }

  @override
  void onError(dynamic e) {
    assert(presenter.heartbeatOnError != null);
    presenter.heartbeatOnError(e);
  }
}

class _CurrenciesObserver implements Observer<List<Currency>> {
  final CurrenciesPresenter presenter;

  _CurrenciesObserver(this.presenter);
  
  @override
  void onComplete() {
    presenter.onCurrenciesComplete();
  }

  @override
  void onError(dynamic error) {
    presenter.onCurrenciesError(error);
  }

  @override
  void onNext(List<Currency> response) {
    presenter.onNextCurrencies(response);
  }
}