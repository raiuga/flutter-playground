import 'package:flutter/material.dart';

import './transaction_list_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text('No Transactions added yet!',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions.map((transaction) {
              return TransactionListItem(
                transaction: transaction,
                deleteTx: deleteTx,
                key: ValueKey(transaction.id),
              );
            }).toList(),
          );

    // LisView.builder currently has a bug regarding keys
    // : ListView.builder(
    //     itemBuilder: (ctx, index) {
    //       return TransactionListItem(
    //         transaction: transactions[index],
    //         deleteTx: deleteTx,
    //         key: ValueKey(transactions[index].id),
    //       );
    //     },
    //     itemCount: transactions.length,
    //   );
  }
}
