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
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
            ),
            FlatButton(
              child: Text('Add transaction'),
              onPressed: () => addAction(_titleController.text, double.tryParse(_amountController.text) ?? 0.0),
            )
          ],
        ),
      ),
    );
  }

}