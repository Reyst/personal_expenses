import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/chart_item.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  @override
  Widget build(BuildContext context) {
    List<ChartItem> data = List.generate(7, fillDayData)..sort((a, b) => a.weekdayNumber.compareTo(b.weekdayNumber));

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _obtainWidgets(data),
        ),
      ),
    );
  }

  List<Widget> _obtainWidgets(List<ChartItem> data) {
    double total = data.fold(0.0, (previousValue, element) => previousValue + element.dayAmount);
    return data.map((item) => Expanded(child: ChartBar(item, total))).toList(growable: false);
  }

  ChartItem fillDayData(int index) {
    final workDay = DateTime.now().subtract(Duration(days: index));

    final dayAmount = transactions
        .where((tx) => isDayCorrect(tx, workDay))
        .toList(growable: false)
        .fold(0.0, (previousValue, element) => previousValue += element.amount);

    return ChartItem(-index, DateFormat.E().format(workDay).substring(0, 1), dayAmount, index == 0);
  }

  bool isDayCorrect(Transaction tx, DateTime workDay) =>
      tx.date.year == workDay.year && tx.date.month == workDay.month && tx.date.day == workDay.day;
}
