import 'package:flutter/material.dart';
import 'package:recordcost/widgets/NewTransaction.dart';
import 'package:recordcost/widgets/transaction_list.dart';
import 'model/transaction.dart';
import 'widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return NewTransaction(pressChange: _addNewTransaction);
      },
    );
  }

  final List<Transaction> _userTransaction = [
    Transaction(
        id: 't12', title: 'new shose', amout: 67.55, date: DateTime.now()),
    Transaction(
        id: 't15', title: "new clothes", amout: 88.55, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amout,DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amout: amout,
        date: DateTime.now());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "flutter app",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chart(_recentTransactions),
          TransactionList(
            transaction: _userTransaction, deleteTx: _deleteTransaction,

          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // 通过这个来调整位置
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
    ;
  }
}
