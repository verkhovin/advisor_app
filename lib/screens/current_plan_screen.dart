import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';
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
    var decode = json.decode('''
{
	"summary": {
		"spent": 1000.00,
		"planned": 3000.00
	},
	"categories": [
		{
			"name": "Food",
			"spent": 100.00,
			"planned": 250.00,
			"status": "OK"
		},
		{
			"name": "Food",
			"spent": 100.00,
			"planned": 250.00,
			"status": "OK"
		},
		{
			"name": "Food",
			"spent": 100.00,
			"planned": 250.00,
			"status": "OK"
		},
		{
			"name": "Food",
			"spent": 100.00,
			"planned": 250.00,
			"status": "OK"
		},
		{
			"name": "Food",
			"spent": 100.00,
			"planned": 250.00,
			"status": "OK"
		},
		{
			"name": "Hobbies",
			"spent": 100.00,
			"planned": 250.00,
			"status": "WARNING"
		},
    {
			"name": "Hobbies",
			"spent": 100.00,
			"planned": 250.00,
			"status": "OVERSPENT"
		}
	]
}

    ''');
    _planStatusScreenData = PlanStatusScreenData.fromJson(decode);
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Month Plan"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Card(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    color: Colors.orange[300],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SpentPlannedWidget(
                          spent: 100,
                          planned: 1000,
                          planStatus: "OK",
                          legend: true),
                    ))),
            Expanded(
              flex: 10,
              child: CategoriesPlan(_planStatusScreenData)
            )
          ],
        ),
      ),
    );
  }
}
