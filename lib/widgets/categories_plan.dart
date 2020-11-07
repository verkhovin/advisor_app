import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';
import 'package:op_advisor/widgets/spent_planned_widget.dart';

class CategoriesPlan extends StatelessWidget {
  final PlanStatusScreenData planStatusScreenData;

  CategoriesPlan(this.planStatusScreenData, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = planStatusScreenData.categories.map((categoryData) {
      return Card(
          margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
          color: cardColor(categoryData.status),
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
                          child: Text(categoryData.name, textAlign: TextAlign.center,),
                        )
                      ],
                    )
                    // child: CircleAvatar(backgroundColor: Colors.white, radius: 30,),
                    ),
                Expanded(
                  flex: 7,
                  child: SpentPlannedWidget(
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
}
