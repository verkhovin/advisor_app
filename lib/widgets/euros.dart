import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Euros extends StatelessWidget {
  final MONEY_FORMAT = NumberFormat.currency(locale: 'en_US', name: '');
  final double value;
  final size;

  Euros(this.value, {Key key, this.size = 10.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("${MONEY_FORMAT.format(value)} €", textAlign: TextAlign.center, style: TextStyle(fontSize: size));
  }
}
