import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models/transaction.dart';
import 'widgets/add_transaction.dart';
import 'widgets/chart.dart';
import 'widgets/empty_transaction_holder.dart';
import 'widgets/transaction_list.dart';

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
        textTheme: ThemeData
            .light()
            .textTheme
            .copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
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
//    Transaction(id: _getId(), title: "Transaction 0", amount: 0.50, date: DateTime.now().subtract(Duration(days: 7))),
//    Transaction(id: _getId(), title: "Transaction 1", amount: 10.50, date: DateTime.now().subtract(Duration(days: 6))),
//    Transaction(id: _getId(), title: "Transaction 2", amount: 20.85, date: DateTime.now().subtract(Duration(days: 5))),
//    Transaction(id: _getId(), title: "Transaction 3", amount: 30.85, date: DateTime.now().subtract(Duration(days: 4))),
//    Transaction(id: _getId(), title: "Transaction 4", amount: 40.85, date: DateTime.now().subtract(Duration(days: 3))),
//    Transaction(id: _getId(), title: "Transaction 5", amount: 50.85, date: DateTime.now().subtract(Duration(days: 2))),
//    Transaction(id: _getId(), title: "Transaction 6", amount: 60.85, date: DateTime.now().subtract(Duration(days: 1))),
//    Transaction(id: _getId(), title: "Transaction 7", amount: 15, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    final border = DateTime.now().subtract(Duration(days: 7));
    return _transactions.where((tx) => tx.date.isAfter(border)).toList(growable: false);
  }

  void _addTx(String title, double amount, DateTime date) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: _getId(),
    );
    setState(() => _transactions.add(newTx));
  }

  void _removeTransaction(String txId) {
    setState(() => _transactions.removeWhere((tx) => tx.id == txId));
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

  double _getAvailableScreenHeight(BuildContext context, List<PreferredSizeWidget> widgets) {
    var queryData = MediaQuery.of(context);
    return queryData.size.height -
        queryData.padding.bottom -
        queryData.padding.top -
        widgets.fold(0, (result, w) => result + w.preferredSize.height);
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
          iconSize: 24,
          icon: Icon(Icons.add),
          onPressed: () => _showAddTxDialog(context),
        ),
      ],
    );

    double workHeight = _getAvailableScreenHeight(context, [appBar]);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 0.3 * workHeight,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: 0.7 * workHeight,
              child: _obtainContent(),
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

  Widget _obtainContent() {
    Widget result;

    if (_transactions.isEmpty)
      result = TransactionListHolder();
    else
      result = TransactionList(
        transactions: _transactions,
        removeAction: _removeTransaction,
      );

    return result;
  }
}
