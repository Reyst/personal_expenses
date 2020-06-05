import 'package:flutter/material.dart';
import 'widgets/add_transaction.dart';
import 'widgets/user_transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  void _showAddTxDialog(BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => NewTransaction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              iconSize: 24,
              icon: Icon(Icons.add),
              onPressed: () => _showAddTxDialog(context),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text("Chart!!!"),
                elevation: 4,
              ),
            ),
            UserTransactions(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        child: Icon(Icons.add),
        onPressed: () => _showAddTxDialog(context),
      ),
    );
  }
}
