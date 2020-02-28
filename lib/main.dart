import 'package:flutter/material.dart';
import 'package:scannerqr/page/qrscan_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LECTO QR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QrScanPage(),
    );
  }
}