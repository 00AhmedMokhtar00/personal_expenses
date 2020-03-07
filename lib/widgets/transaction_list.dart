import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modules/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  Widget build(BuildContext context) {
    final MediaQ = MediaQuery.of(context);
    return transactions.isNotEmpty
        ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2.0),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(5.0),
                      child: FittedBox(
                        child: Text(
                          '${transactions[transactions.length - index - 1].amount.toStringAsFixed(2)} LE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.green),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transactions[transactions.length - 1 - index].title}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '${DateFormat.yMMMd().format(transactions[transactions.length - 1 - index].date)}'),
                    trailing: MediaQ.size.width <= 400?IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => deleteTransaction(transactions[transactions.length - 1 - index].id),
                    ): FlatButton.icon(
                      label: Text('Delete'),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => deleteTransaction(transactions[transactions.length - 1 - index].id),
                    ),
                  ),
                );
              },
            )
        : Center(
            child: Image(
            image: AssetImage('assets/images/empty.png'),
          ));
  }
}
