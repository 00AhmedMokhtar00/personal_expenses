import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/transaction_list.dart';
import 'modules/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';

main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
 return runApp(PersonalExpenses());
}

class PersonalExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Expenses',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Trade'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> transactions = [];

  bool switchVal = true;


  @override
  Widget build(BuildContext context) {
    final MediaQ = MediaQuery.of(context);

    final PreferredSizeWidget appBar = Platform.isIOS?
    CupertinoNavigationBar(
      middle: Text('Daily Expenses'),
      trailing: GestureDetector(
        onTap: () => startAddingNewTransaction(context),
        child: Icon(CupertinoIcons.add),
      ),
    ):AppBar(
      actions: <Widget>[
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => startAddingNewTransaction(context),
        )
      ],
      title: Text('Daliy Expences'),
    );

    final isLandscape = MediaQ.orientation == Orientation.landscape;

    final tranList = Container(
        height:(MediaQ.size.height - appBar.preferredSize.height - MediaQ.padding.top)*0.7,
        child: TransactionList(transactions, _deleteTransaction)
    );

    chartWidget(double ratio){
      return Container(
          height: (MediaQ.size.height - appBar.preferredSize.height - MediaQ.padding.top)*ratio,
          child: Chart(recentTransactions)
      );
    }

    final pageBody = SafeArea(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if(!isLandscape)
          chartWidget(0.3),
        if(!isLandscape)
          tranList,
        if(isLandscape)
          showChart(),
        if(isLandscape)
          switchVal?
          chartWidget(0.7): tranList
      ],
    ));


    return Platform.isIOS?CupertinoPageScaffold(child: pageBody,navigationBar: appBar,):Scaffold(
      appBar: appBar,

      body: pageBody,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Platform.isIOS?FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddingNewTransaction(context),
      ) : null,
    );
  }

  showChart(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart', style: Theme.of(context).textTheme.title,),
        Switch.adaptive(
          value: switchVal,
          onChanged: (val){
            setState(() {
              switchVal = val;
            });
          },
        )
      ],
    );
  }



  List<Transaction> get recentTransactions {
    return transactions.where((elem) {
      return elem.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double amount, DateTime transactionDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        id: transactions.length + 1,
        date: transactionDate);

    setState(() {
      transactions.add(newTx);
    });
  }

  _deleteTransaction(int id) {
    setState(() {
      transactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).primaryColorDark,
        context: ctx,
        builder: (_) {
          return NewTransaction(addTransaction: _addTransaction);
        });
  }
}
