import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcointicker/CoinData.dart';
import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var selectedCurrency = currenciesList.first;
  var selectedCrypto = cryptoList.first;
  String bitcoinValue = 'AUD';
  bool isWaiting = false;
  Map<String, String> coinValues = {};

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> dropdownMenuItem = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownMenuItem.add(item);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropdownMenuItem,
      onChanged: <String>(value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> dropdownMenuItem = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      dropdownMenuItem.add(item);
    }
    return CupertinoPicker(
        backgroundColor: Colors.deepPurple,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            getData();
          });
        },
        children: dropdownMenuItem);
  }

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData()
          .getData(crypto: selectedCrypto, currency: selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    Column makeCard() {
      List<CardWidget> childData = [];
      for (String crypto in cryptoList) {
        childData.add(CardWidget(
            crypto: crypto,
            currency: selectedCurrency,
            rate: isWaiting ? '?' : coinValues[crypto].toString()));
      }
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: childData,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCard(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.deepPurple,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.crypto,
    required this.currency,
    required this.rate,
  });

  final String crypto;
  final String currency;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.deepPurpleAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $rate $currency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
