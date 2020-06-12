import 'package:flutter/material.dart';

import '../models/chart_item.dart';

class ChartBar extends StatelessWidget {
  final ChartItem chartItem;
  final double total;

  ChartBar(this.chartItem, this.total);

  @override
  Widget build(BuildContext context) {
    final dayAmount = chartItem.dayAmount;
    final label = chartItem.label;

    double fraction = total > 0 ? chartItem.dayAmount / total : 0;
    final baseStyle = Theme.of(context).textTheme.title;
    final labelStyle = chartItem.isHighlighted ? baseStyle.copyWith(color: Theme.of(context).primaryColor) : baseStyle;

    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        margin: EdgeInsets.all(2),
        child: Column(
          children: [
            Container(
              height: 20,
              child: FittedBox(
                child: Text("\$${dayAmount.toStringAsFixed(0)}"),
              ),
            ),
            SizedBox(height: 4),
            Container(
              height: 60,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[400],
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: fraction,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 6),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}
