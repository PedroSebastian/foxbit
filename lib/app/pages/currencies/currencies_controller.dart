import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_client/data/helpers/websocket.dart';
import 'package:foxbit_client/domain/entities/currency.dart';

import 'currencies_presenter.dart';

class CurrenciesController extends Controller {
  CurrenciesPresenter presenter;
  final FoxbitWebSocket webSocket;
  List<Currency> currencies = [];
  bool isLoading = false;
  bool hasError = false;

  CurrenciesController() : webSocket = FoxbitWebSocket() {
    isLoading = true;
    webSocket.connect();
    presenter.sendHeartbeat(webSocket);
    presenter.getCurrencies();
  }

  @override
  void onDisposed() {
    webSocket.disconnect();
    super.onDisposed();
  }

  @override
  void initListeners() {
    presenter = CurrenciesPresenter(webSocket);

    presenter.heartbeatOnComplete = heartbeatOnComplete;
    presenter.heartbeatOnError = heartbeatOnError;

    presenter.onCurrenciesComplete = onCurrenciesComplete;
    presenter.onNextCurrencies = onNextCurrencies;
    presenter.onCurrenciesError = onCurrenciesError;
  }

  void heartbeatOnComplete() {
    _scheduleNextHeartbeat();
  }

  void heartbeatOnError(dynamic error) {
    isLoading = false;
    hasError = true;
    showSnackbarMessage('Oops! Não foi possível estabelecer a conexão.');

    _scheduleNextHeartbeat();
  }

  void showSnackbarMessage(String message) {
    ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message)));
  }

  void _scheduleNextHeartbeat() {
    Timer(const Duration(seconds: 30), () {
      presenter.sendHeartbeat(webSocket);
    });
  }

  void onCurrenciesComplete() {
    isLoading = false;
    refreshUI();
  }

  void onCurrenciesError(dynamic error) {
    hasError = true;
    isLoading = false;
    showSnackbarMessage('Oops! Tivemos um erro ao carregar as cotações. Tente em alguns instantes.');
  }

  void onNextCurrencies(List<Currency> currencies) {
    this.currencies.addAll(currencies);
  }
}
