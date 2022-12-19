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
        ? Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text('List is Empty',style: Theme.of(context).textTheme.titleLarge,),
                // Expanded(
                //   child:
                Image.asset('assets/image/no_value.jpg')
                // )
              ],
            ),
          )
        : Container(
            height: 300,
            child: ListView.builder(
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
                      onPressed:() => deleteTransation!(transactions![index].id),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
