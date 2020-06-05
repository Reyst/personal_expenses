import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/transaction.dart';
import 'add_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserTransactionsState();
  }
}

class _UserTransactionsState extends State<UserTransactions> {
  static final _idGenerator = Uuid();

  static String _getId() => _idGenerator.v4();

  final List<Transaction> _transactions = [
    Transaction(id: _getId(), title: "Transaction 1", amount: 100.50, date: DateTime.now()),
    Transaction(id: _getId(), title: "Transaction 2", amount: 50.33, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(
          addAction: _addTx,
        ),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }

  void _addTx(String title, double amount) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: _getId(),
    );
    setState(() => _transactions.add(newTx));
  }
}
