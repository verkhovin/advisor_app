import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';
import 'package:op_advisor/backend/model/suggestion.dart';
import 'package:op_advisor/screens/category_transactions.dart';
import 'package:op_advisor/widgets/amount.dart';
import 'package:op_advisor/widgets/editable_spend_widget.dart';
import 'package:op_advisor/widgets/spent_planned_widget.dart';
import 'package:op_advisor/widgets/util.dart';

class CategoriesPlan extends StatelessWidget {
  final PlanStatusScreenData planStatusScreenData;
  final bool editable;
  final void Function() editedCallback;
  final bool showSpent;
  final Future<List<Suggestion>> suggestionsFuture;

  CategoriesPlan(this.planStatusScreenData,
      {Key key,
      this.editable = false,
      this.editedCallback,
      this.showSpent,
      this.suggestionsFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = planStatusScreenData.categories.map((categoryData) {
      return GestureDetector(
        onTap: !editable
            ? () {
                var now = DateTime.now();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryTransactions(
                        categoryId: categoryData.id,
                        categoryName: categoryData.name,
                        month: now.month,
                        year: now.year),
                  ),
                );
              }
            : null,
        child: Card(
            margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
            color: editable ? null : cardColor(categoryData.status),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              buildCircleAvatar(categoryData.id),
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
                          child: Column(
                            children: [
                              buildSpenView(categoryData),
                            ],
                          )),
                    ],
                  ),
                  editable ? Divider(thickness: 1.0) : Container(),
                  editable ? buildAmount(categoryData.id) : Container()
                ],
              ),
            )),
      );
    }).toList();
    return ListView(
      children: cards,
    );
  }

  Widget buildAmount(int categoryId) {
    return FutureBuilder(
      future: suggestionsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        } else if (snapshot.connectionState == ConnectionState.done) {
          var data = (snapshot.data as List<Suggestion>);
          var suggestion =
              data.firstWhere((element) => element.id == categoryId);
          return Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Amount(
                      20.0, suggestion.userAverage, "Your average spending")),
              Expanded(
                  flex: 1,
                  child: VerticalDivider(
                    thickness: 1.0,
                  )),
              Expanded(
                  flex: 5,
                  child:
                      Amount(20.0, suggestion.allAverage, "Suggested spending"))
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Container buildSpenView(CategoryPlan categoryData) {
    return Container(
      child: editable
          ? EditableSpendWidget(
              spent: categoryData.spent,
              planned: categoryData.planned,
              planStatus: categoryData.status,
              legend: true,
              updateValueCallback: (v) {
                categoryData.planned = v;
                editedCallback();
              },
              showSpent: showSpent)
          : SpentPlannedWidget(
              spent: categoryData.spent,
              planned: categoryData.planned,
              planStatus: categoryData.status),
    );
  }
}
