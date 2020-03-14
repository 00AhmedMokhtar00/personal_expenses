import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/modules/transaction.dart';



class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  TransactionItem({this.transaction, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: ListTile(
        leading: Container(
          margin:
          EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2.0),
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(5.0),
          child: FittedBox(
            child: Text(
              '${transaction.amount.toStringAsFixed(2)} LE',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.green),
            ),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            '${DateFormat.yMMMd().format(transaction.date)}'),
        trailing: MediaQuery.of(context).size.width <= 400?IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => deleteTransaction(transaction.id),
        ): FlatButton.icon(
          label: Text('Delete'),
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}
