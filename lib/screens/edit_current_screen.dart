import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';
import 'package:op_advisor/backend/model/suggestion.dart';
import 'package:op_advisor/backend/plan.dart';
import 'package:op_advisor/widgets/categories_plan.dart';
import 'package:op_advisor/widgets/euros.dart';
import 'package:op_advisor/widgets/util.dart';

class EditCurrentPlanScreen extends StatefulWidget {
  final int month;
  final int year;
  final bool showSpent;

  const EditCurrentPlanScreen({Key key, this.month, this.year, this.showSpent = true})
      : super(key: key);

  @override
  _EditCurrentPlanScreenState createState() =>
      _EditCurrentPlanScreenState(month, year);
}

class _EditCurrentPlanScreenState extends State<EditCurrentPlanScreen> {
  Future<PlanStatusScreenData> _dataFuture;
  Future<List<Suggestion>> _suggestionsFuture;
  PlanStatusScreenData _data;
  double _sum;


  _EditCurrentPlanScreenState(month, year) {
    _dataFuture = fetchPlanForEdit(month, year);
    _suggestionsFuture = fetchSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit your plan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              print(json.encode(_data.toJson()));
              updateCurrentMonthPlan(_data, widget.month, widget.year).then((
                  value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (r) => false));
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _dataFuture,
          builder: (context, AsyncSnapshot<PlanStatusScreenData> snapshot) =>
              buildScreen(snapshot),
        ),
      ),
    );
  }

  Widget buildScreen(AsyncSnapshot<PlanStatusScreenData> snapshot) {
    if (snapshot.hasError) {
      return Text("Error occured :(");
    } else if (snapshot.connectionState == ConnectionState.done) {
      _data = snapshot.data;
      _sum = countSum();
      var header;
      if (widget.month == DateTime.now().month) {
        header = "Your plan to spend this month";
      } else {
        String month = monthName(widget.month);
        header = "Your plan to spend in $month";
      }
      return Column(
        children: [
          Expanded(
              flex: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom != 0 ? 0 : 3,
              child: Card(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  color: Colors.orange[300],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(header),
                                Euros(_sum, size: 30.0),
                              ],
                            ),
                          ],
                        )),
                  ))),
          Expanded(
              flex: 10,
              child: CategoriesPlan(
                _data,
                editable: true,
                editedCallback: () {
                  setState(() {
                    _sum = countSum();
                  });
                },
                showSpent: widget.showSpent,
                suggestionsFuture: _suggestionsFuture,
              ))
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: CircularProgressIndicator(),
      );
    }
  }

  double countSum() {
    return _data.categories
        .map((category) => category.planned)
        .fold(0.0, (p, c) => p + c);
  }
}
