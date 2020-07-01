import 'package:flutter/material.dart';

import '../models/chart_item.dart';

class ChartBar extends StatelessWidget {
  final ChartItem chartItem;
  final double total;

  const ChartBar(this.chartItem, this.total);

  @override
  Widget build(BuildContext context) {
    final dayAmount = chartItem.dayAmount;
    final label = chartItem.label;

    double fraction = total > 0 ? chartItem.dayAmount / total : 0;
    final baseStyle = Theme.of(context).textTheme.title;
    final labelStyle = chartItem.isHighlighted ? baseStyle.copyWith(color: Theme.of(context).primaryColor) : baseStyle;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        var mHeight = constraints.maxHeight;
        return Container(
          margin: EdgeInsets.all(2),
          child: Column(
            children: [
              Container(
                height: mHeight * 0.2,
                child: FittedBox(
                  child: Text("\$${dayAmount.toStringAsFixed(0)}"),
                ),
              ),
              SizedBox(height: mHeight * 0.05),
              Container(
                height: mHeight * 0.5,
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
              SizedBox(height: mHeight * 0.05),
              Container(
                child: FittedBox(
                  child: Text(label, style: labelStyle),
                ),
                height: mHeight * 0.1,
              ),
            ],
          ),
        );
      },
    );

//    return Flexible(
//      fit: FlexFit.loose,
//      child: Container(
//        margin: EdgeInsets.all(2),
//        child: Column(
//          children: [
//            Container(
//              height: 20,
//              child: FittedBox(
//                child: Text("\$${dayAmount.toStringAsFixed(0)}"),
//              ),
//            ),
//            SizedBox(height: 4),
//            Container(
//              height: 60,
//              width: 10,
//              child: Stack(
//                alignment: Alignment.bottomCenter,
//                children: [
//                  Container(
//                    decoration: BoxDecoration(
//                      border: Border.all(color: Colors.grey),
//                      borderRadius: BorderRadius.all(Radius.circular(10)),
//                      color: Colors.grey[400],
//                    ),
//                  ),
//                  FractionallySizedBox(
//                    heightFactor: fraction,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(10)),
//                        color: Theme.of(context).accentColor,
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ),
//            SizedBox(height: 6),
//            Text(label, style: labelStyle),
//          ],
//        ),
//      ),
//    );
  }
}
