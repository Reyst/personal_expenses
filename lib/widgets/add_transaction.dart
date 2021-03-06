import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) addAction;

  NewTransaction({Key key, this.addAction}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  String get _strSelectedDate {
    return _selectedDate == null ? 'Date is not selected yet!' : DateFormat.yMMMd().format(_selectedDate);
  }

  void _submitData() {
    var title = _titleController.text;
    var amount = double.tryParse(_amountController.text) ?? 0.0;
    if (title.isNotEmpty && amount > 0 && _selectedDate != null) {
      widget.addAction(title, amount, _selectedDate);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType:  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(child: Text(_strSelectedDate)),
                  AdaptiveFlatButton(
                    caption: 'Choose date',
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: themeData.primaryColor,
              child: Text(
                'Add transaction',
                style: themeData.textTheme.button,
              ),
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    ).then((date) => _updateSelectedDate(date));
  }

  void _updateSelectedDate(DateTime newDate) {
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }
}
