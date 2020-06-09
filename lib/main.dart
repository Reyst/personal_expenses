import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models/transaction.dart';
import 'widgets/add_transaction.dart';
import 'widgets/transaction_list.dart';
//import 'widgets/user_transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        hintColor: Colors.blueGrey,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 8,
          modalBackgroundColor: Colors.purple[100],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final _idGenerator = Uuid();

  static String _getId() => _idGenerator.v4();

  final List<Transaction> _transactions = [
    Transaction(id: _getId(), title: "Transaction 1", amount: 100.50, date: DateTime.now()),
    Transaction(id: _getId(), title: "Transaction 2", amount: 50.33, date: DateTime.now()),
  ];

  void _addTx(String title, double amount) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: _getId(),
    );
    setState(() => _transactions.add(newTx));
  }

  void _showAddTxDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addAction: _addTx),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: <Widget>[
          IconButton(
            iconSize: 24,
            icon: Icon(Icons.add),
            onPressed: () => _showAddTxDialog(context),
          ),
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
            TransactionList(
              transactions: _transactions,
            ),
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
