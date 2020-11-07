import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'euros.dart';

class SpentPlannedWidget extends StatelessWidget {
  final double spent;
  final double planned;
  final String planStatus;
  final bool legend;

  final size = 20.0;
  const SpentPlannedWidget({Key key, this.spent, this.planned, this.planStatus, this.legend = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 5, child: buildLabel(spent, "Spent")),
            Expanded(flex: 1, child: VerticalDivider(thickness: 1.0,)),
            Expanded(flex: 5, child: buildLabel(planned, "Planned")),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(double value, String title) {
    if (legend) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Euros(value, size: size),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(title, style: TextStyle(color: Colors.orange[100]),),
          )
        ],
      );
    }
    return Euros(value, size: size);

  }
}
