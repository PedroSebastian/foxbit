import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_client/app/pages/currencies/currencies_presenter.dart';
import 'package:foxbit_client/data/helpers/websocket.dart';
import 'package:foxbit_client/domain/entities/currency.dart';

class CurrenciesController extends Controller {
  CurrenciesPresenter presenter;
  final FoxbitWebSocket webSocket;
  List<Currency> currencies = [];
  bool isLoading = false;
  bool hasError = false;
  bool noConnectionError = false;

  CurrenciesController() : webSocket = FoxbitWebSocket() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    noConnectionError = false;
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      noConnectionError = true;
      refreshUI();
      showSnackbarMessage('Oops! Verifique sua conexão e tente novamente.');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      webSocket.connect();
      presenter.sendHeartbeat(webSocket);
      presenter.getCurrencies();
    }
  }

  void retry() {
    hasError = false;
    init();
    refreshUI();
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

    _scheduleCurrenciesUpdate();
  }

  void onCurrenciesError(dynamic error) {
    if (!hasError) {
      hasError = true;
      showSnackbarMessage('Oops! Tivemos um erro ao carregar as cotações. Tente em alguns instantes.');
    }

    isLoading = false;
    refreshUI();
  }

  void onNextCurrencies(List<Currency> currencies) {
    this.currencies.clear();
    this.currencies.addAll(currencies);
  }

  void _scheduleCurrenciesUpdate() {
    Timer(const Duration(seconds: 5), () async {
      final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return;
      }

      presenter.getCurrencies();
    });
  }
}
