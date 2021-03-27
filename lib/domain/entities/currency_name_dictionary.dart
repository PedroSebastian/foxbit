const Map<String, String> currenciesDictionary = {
  'BTC': 'Bitcoin',
  'XRP': 'XRP',
  'TUSD': 'TrueUSD',
  'ETH': 'Ethereum',
  'LTC': 'Litecoin',
  'LINK': 'Chainlink'
};

String getCurrencyName(String symbol) {
  return currenciesDictionary[symbol.toUpperCase()];
}