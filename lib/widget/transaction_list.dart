import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expensive/model/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList({this.transactions, this.deleteTransation});
  final List<Transaction>? transactions;
  final Function? deleteTransation;

  @override
  Widget build(BuildContext context) {
    return transactions!.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'List is Empty',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal:5 ),
                     child: Image(
                        height: constraints.maxHeight * 0.6,
                        image: const AssetImage('assets/image/no_value.jpg')),
                   )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: Text(
                      '\$${transactions![index].amount.toString()}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  title: Text(
                    transactions![index].title.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMEd().format(transactions![index].date!)),
                  trailing: IconButton(
                    onPressed: () => deleteTransation!(transactions![index].id),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
