import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'euros.dart';

class EditableSpendWidget extends StatefulWidget {
  final double spent;
  final double planned;
  final String planStatus;
  final bool legend;
  final void Function(double) updateValueCallback;

  final size = 20.0;
  const EditableSpendWidget({Key key, this.spent, this.planned, this.planStatus, this.legend = false, this.updateValueCallback}) : super(key: key);

  @override
  _EditableSpendWidgetState createState() => _EditableSpendWidgetState(planned.toStringAsFixed(2));
}

class _EditableSpendWidgetState extends State<EditableSpendWidget> {
  TextEditingController _textController;

  _EditableSpendWidgetState(initialState) {
   this._textController =  TextEditingController(text: initialState);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _textController.addListener((){
      setState(() {
        widget.updateValueCallback(double.parse(_textController.text));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // textController.text = widget.planned.toStringAsFixed(2);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 5, child: buildLabel(widget.spent, "Already spent")),
            Expanded(flex: 1, child: VerticalDivider(thickness: 1.0,)),
            Expanded(flex: 5, child: TextField(controller: _textController, keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Plan"), onChanged: (v) {
              // widget.updateValueCallback(double.parse(v));

            })),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(double value, String title) {
    if (widget.legend) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Euros(value, size: widget.size),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(title, style: TextStyle(),),
          )
        ],
      );
    }
    return Euros(value, size: widget.size);

  }
}