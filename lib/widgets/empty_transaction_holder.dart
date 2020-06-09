import 'package:flutter/material.dart';

class TransactionListHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "There are no any transactions!!!",
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          height: 200,
          child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
