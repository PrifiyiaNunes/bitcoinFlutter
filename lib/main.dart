import 'package:flutter/material.dart';
import 'package:bitcointicker/Screens/PriceScreen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitCoin Ticker',
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}