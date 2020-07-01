import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models/transaction.dart';
import 'widgets/add_transaction.dart';
import 'widgets/chart.dart';
import 'widgets/empty_transaction_holder.dart';
import 'widgets/transaction_list.dart';

void main() {
/*
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
*/
  runApp(MyApp());
}

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
              button: TextStyle(color: Colors.white),
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

  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    final border = DateTime.now().subtract(Duration(days: 7));
    return _transactions.where((tx) => tx.date.isAfter(border)).toList(growable: false);
  }

  bool _displayChart = false;

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
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: mediaQuery.viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: NewTransaction(addAction: _addTx),
            ),
          ),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  double _getAvailableScreenHeight(MediaQueryData queryData, List<PreferredSizeWidget> widgets) {
    return queryData.size.height -
        queryData.padding.bottom -
        queryData.padding.top -
        widgets.fold(0, (result, w) => result + w.preferredSize.height);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final isLandscape = mediaQueryData.orientation == Orientation.landscape;

    PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _showAddTxDialog(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text("Personal Expenses"),
            actions: <Widget>[
              IconButton(
                iconSize: 24,
                icon: Icon(Icons.add),
                onPressed: () => _showAddTxDialog(context),
              ),
            ],
          );

    double workHeight = _getAvailableScreenHeight(mediaQueryData, [appBar]);

    var mainPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _getMainScreenContent(workHeight, isLandscape),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: mainPage,
          )
        : Scaffold(
            appBar: appBar,
            body: mainPage,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              elevation: 4,
              child: Icon(Icons.add),
              onPressed: () => _showAddTxDialog(context),
            ),
          );
  }

  List<Widget> _getMainScreenContent(double workHeight, bool isLandscape) {
    var chart = Container(
      height: (isLandscape ? 0.8 : 0.3) * workHeight,
      child: Chart(_recentTransactions),
    );

    var txList = Container(
      height: 0.7 * workHeight,
      child: _obtainTransactionListContent(),
    );

    return <Widget>[
      if (isLandscape)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("List"),
            Switch.adaptive(
              value: _displayChart,
              onChanged: (value) => setState(() => _displayChart = value),
            ),
            Text("Chart"),
          ],
        ),
      if (isLandscape && _displayChart) chart,
      if (isLandscape && !_displayChart) txList,
      if (!isLandscape) ...[
        chart,
        txList,
      ],
    ];
  }

  Widget _obtainTransactionListContent() {
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
