import 'package:flutter/material.dart';
import 'package:op_advisor/screens/current_plan_screen.dart';
import 'package:op_advisor/screens/edit_current_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OP SpendAdvisor',
        initialRoute: '/',
        routes: {
          '/': (context) => CurrentPlanScreen(),
          '/edit': (context) {
            var now = DateTime.now();
            return EditCurrentPlanScreen(month: now.month, year: now.year);
          },
          '/next': (context) {
            var now = DateTime.now();
            var month;
            var year;
            if(now.month == 12) {
              month = 1;
              year = now.year + 1;
            } else {
              month = now.month + 1;
              year = now.year;
            }
            return EditCurrentPlanScreen(month: month, year: year);
          },
        },
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: Colors.orange[600],

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ));
  }
}
