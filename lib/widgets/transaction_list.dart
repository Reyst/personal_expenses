import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({Key key, this.transactions}) : super(key: key);

  Color _highlightedTextColor;

  @override
  Widget build(BuildContext context) {
    _highlightedTextColor = Theme.of(context).primaryColor;

    return Container(
      height: 550,
      child: ListView.builder(
        itemBuilder: (ctx, index) => txToWidget(context, transactions[index]),
        itemCount: transactions.length,
      ),
    );
  }

  Widget txToWidget(BuildContext context, Transaction tx) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: _highlightedTextColor,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              "\$${tx.amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: _highlightedTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                tx.title,
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                DateFormat.yMMMd().format(tx.date),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
