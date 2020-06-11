import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color highlightedTextColor = Theme.of(context).primaryColor;

    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) => txToWidget(
          context,
          transactions[index],
          highlightedTextColor,
        ),
        itemCount: transactions.length,
      ),
    );
  }

  Widget txToWidget(BuildContext context, Transaction tx, Color specialColor) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${tx.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(tx.date),
        ),
      ),
    );
  }

/*
  Widget txToWidget(BuildContext context, Transaction tx, Color specialColor) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0
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
                color: specialColor,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              "\$${tx.amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: specialColor,
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
*/
}
