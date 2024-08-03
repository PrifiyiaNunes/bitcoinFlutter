import 'package:bitcointicker/Services/NetworkHelper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future getData({required String crypto, required String currency}) async {
    NetworkHelper networkHelper = NetworkHelper();
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      var rateValue = await networkHelper.getCurrencyData(crypto: crypto, currency: currency);
      double rate = rateValue['rate'];
      cryptoPrices[crypto] = rate.toStringAsFixed(0);
    }
    return cryptoPrices;
  }
}
