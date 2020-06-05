import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function(String, double) addAction;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  NewTransaction({Key key, this.addAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _addTx(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _addTx(),
            ),
            FlatButton(
              child: Text('Add transaction'),
              onPressed: _addTx,
            )
          ],
        ),
      ),
    );
  }

  void _addTx() {
    var title = _titleController.text;
    var amount = double.tryParse(_amountController.text) ?? 0.0;
    if (title.isNotEmpty && amount > 0) {
      addAction(title, amount);
    }
  }
}