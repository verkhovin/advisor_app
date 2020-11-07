import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';
import 'package:op_advisor/backend/plan.dart';
import 'package:op_advisor/widgets/categories_plan.dart';
import 'package:op_advisor/widgets/spent_planned_widget.dart';

class CurrentPlanScreen extends StatefulWidget {
  @override
  _CurrentPlanScreenState createState() => _CurrentPlanScreenState();
}

class _CurrentPlanScreenState extends State<CurrentPlanScreen> {
  PlanStatusScreenData _planStatusScreenData = null;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Month Plan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              this.setState(() {

              });
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchCurrentMonthPlan(),
          builder: (context, AsyncSnapshot<PlanStatusScreenData> snapshot) => buildScreen(snapshot),
        ),
      ),
    );
  }

  Widget buildScreen(AsyncSnapshot<PlanStatusScreenData> snapshot) {
     if (snapshot.connectionState == ConnectionState.done) {
      return Column(
        children: [
          Expanded(
              flex: 3,
              child: Card(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  color: Colors.orange[300],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SpentPlannedWidget(
                        spent: snapshot.data.summary.spent,
                        planned: snapshot.data.summary.planned,
                        planStatus: "OK",
                        legend: true),
                  ))),
          Expanded(
              flex: 10,
              child: CategoriesPlan(snapshot.data)
          )
        ],
      );
    } else if (snapshot.hasError) {
      return Text("Error occured :(");
    } else {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: CircularProgressIndicator(),
      );
    }
  }
}
