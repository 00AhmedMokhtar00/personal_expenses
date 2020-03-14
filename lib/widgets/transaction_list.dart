import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';
import '../modules/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(transaction: transactions[transactions.length - 1 - index], deleteTransaction: deleteTransaction);
              },
            )
        : Center(
            child: Image(
            image: AssetImage('assets/images/empty.png'),
          ));
  }
}
