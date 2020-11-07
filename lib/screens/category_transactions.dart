import 'package:flutter/material.dart';
import 'package:op_advisor/backend/model/transaction.dart';
import 'package:op_advisor/backend/plan.dart';
import 'package:op_advisor/widgets/euros.dart';
import 'package:intl/intl.dart';
import 'package:op_advisor/widgets/util.dart';

class CategoryTransactions extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final int month;
  final int year;

  const CategoryTransactions(
      {Key key, this.categoryId, this.month, this.year, this.categoryName})
      : super(key: key);

  @override
  _CategoryTransactionsState createState() =>
      _CategoryTransactionsState(categoryId, month, year);
}

class _CategoryTransactionsState extends State<CategoryTransactions> {
  Future<List<Transaction>> _transactionsFuture;


  _CategoryTransactionsState(categoryId, month, year) {
    _transactionsFuture = fetchTransactions(categoryId, month, year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(
        child: FutureBuilder(
          future: _transactionsFuture,
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Text("Error occured");
            }
            if(snapshot.connectionState == ConnectionState.done) {
              var transactions = snapshot.data as List<Transaction>;
              double sum = transactions.map((e) => e.amount).fold(0.0, (p, c) => p + c);
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
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                            child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("In ${monthName(widget.month)} you spend on ${widget.categoryName}"),
                                        Euros(sum, size: 30.0),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Text("${transactions.length} transactions", style: TextStyle(color: Colors.black45)),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ))),
                  Expanded(
                    flex: 10,
                    child: ListView(
                      children: transactions.map((transaction) => Card(
                      margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                          children: [
                            Text(transaction.name, style: TextStyle(fontSize: 20.0),),
                            Text(DateFormat('yyyy-MM-dd – kk:mm').format(transaction.timestamp), style: TextStyle(color: Colors.black45),)
                          ]),
                            VerticalDivider(thickness: 1.0,),
                            Euros(transaction.amount, size: 20.0),
                          ],
                        ),
                      )))).toList(),
                    ),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },

        ),
      ),
    );
  }
}

