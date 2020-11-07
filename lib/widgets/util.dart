import 'package:flutter/material.dart';
import 'package:op_advisor/icons/advisor_icons_icons.dart';
import 'package:intl/intl.dart';

CircleAvatar buildCircleAvatar(int categoryId) {
  return CircleAvatar(
    radius: 30,
    backgroundColor: Colors.orange[300],
    child: CircleAvatar(
      radius: 28,
      backgroundColor: Colors.yellow[100],
      child: Icon(AdvisorIcons.get(categoryId), size: 50.0, color: Colors.black87),
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


String monthName(int monthNum) {
  final DateTime monthDateTime = new DateTime(2020, monthNum);
  final DateFormat formatter = DateFormat('MMMM');
  final String month = formatter.format(monthDateTime);
  return month;
}