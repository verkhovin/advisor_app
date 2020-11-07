import 'package:flutter/material.dart';

CircleAvatar buildCircleAvatar() {
  return CircleAvatar(
    radius: 30,
    backgroundColor: Colors.orange[300],
    child: CircleAvatar(
      radius: 28,
      backgroundColor: Colors.yellow[100],
    ),
  );
}

Color cardColor(String status) {
  if (status == 'WARNING') {
    return Colors.yellow[100];
  } else if (status == 'OVERSPENT') {
    return Color(0xfffa947a);
  }
  return Colors.green[100];
}