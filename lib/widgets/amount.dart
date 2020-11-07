import 'package:flutter/material.dart';
import 'package:op_advisor/widgets/euros.dart';

class Amount extends StatelessWidget {
  final double amount;
  final double size;
  final String title;

  Amount(this.size, this.amount, this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Euros(amount, size: size),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(title, style: TextStyle(color: Colors.black54),),
        )
      ],
    );
  }
}
