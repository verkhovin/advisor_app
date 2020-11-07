import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';
import 'package:op_advisor/widgets/editable_spend_widget.dart';
import 'package:op_advisor/widgets/spent_planned_widget.dart';
import 'package:op_advisor/widgets/util.dart';

class CategoriesPlan extends StatelessWidget {
  final PlanStatusScreenData planStatusScreenData;
  final bool editable;
  final void Function() editedCallback;

  CategoriesPlan(this.planStatusScreenData, {Key key, this.editable = false, this.editedCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = planStatusScreenData.categories.map((categoryData) {
      return Card(
          margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
          color: editable ? null : cardColor(categoryData.status),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        buildCircleAvatar(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            categoryData.name,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                    // child: CircleAvatar(backgroundColor: Colors.white, radius: 30,),
                    ),
                Expanded(
                  flex: 7,
                  child: editable
                      ? EditableSpendWidget(
                          spent: categoryData.spent,
                          planned: categoryData.planned,
                          planStatus: categoryData.status,
                          legend: true,
                          updateValueCallback: (v) {categoryData.planned = v; editedCallback();},)
                      : SpentPlannedWidget(
                          spent: categoryData.spent,
                          planned: categoryData.planned,
                          planStatus: categoryData.status),
                ),
              ],
            ),
          ));
    }).toList();
    return ListView(
      children: cards,
    );
  }
}
