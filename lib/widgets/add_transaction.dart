import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  final Function(String, double) addAction;

  NewTransaction({Key key, this.addAction}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();

}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _submitData() {
    var title = _titleController.text;
    var amount = double.tryParse(_amountController.text) ?? 0.0;
    if (title.isNotEmpty && amount > 0) {
      widget.addAction(title, amount);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
            FlatButton(
              child: Text('Add transaction'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}