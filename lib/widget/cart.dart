import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expensive/model/transaction.dart';
import 'package:personal_expensive/widget/chart_bar.dart';

class Cart extends StatelessWidget {
  Cart({this.recentTransactions});
  List<Transaction>? recentTransactions;
  // List weekday = [];
  // List<Map<String, Object>> get groupedTransactionValue {
  //   return List.generate(7, (index) {
  //     final weekDay = DateTime.now().subtract(Duration(days: index));
  //     var totolSum = 0.0;
  //     for (var i = 0; i <= recentTransaction!.length; i++) {
  //       if (recentTransaction![i].date!.day == weekDay.day &&
  //           recentTransaction![i].date!.day == weekDay.month &&
  //           recentTransaction![i].date!.day == weekDay.year) {
  //         totolSum += recentTransaction![i].amount!;
  //       }
  //     }
  //     print(totolSum);
  //     print(DateFormat.E().format(weekDay));
  //     return {'day': DateFormat.yMMMEd().format(weekDay), 'amount': totolSum};
  //   });
  // }

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions!.length; i++) {
        if (recentTransactions![i].date!.day == weekDay.day &&
            recentTransactions![i].date!.month == weekDay.month &&
            recentTransactions![i].date!.year == weekDay.year) {
          totalSum += recentTransactions![i].amount!;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValue);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 2,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Expanded(
                  child: ChartBar(
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalSpending == 0
                    ? 0
                    : (data["amount"] as double) / totalSpending,
                label: data['day'],
              )
                  //   Column(
                  //     children: [
                  //     Text(e['amount'].toString()),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Container(
                  //       height: 100,
                  //       color: Colors.grey,
                  //       width: 20,
                  //       // decoration: BoxDecoration(
                  //       //     color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                  //       child: Stack(
                  //         children: [
                  //         Container(
                  //           // height: 30,
                  //           decoration: BoxDecoration(
                  //             color: Colors.blue,
                  //             borderRadius: BorderRadius.circular(5),
                  //           ),
                  //         ),
                  //         FractionallySizedBox(
                  //           heightFactor: totalSpending,
                  //           child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Theme.of(context).primaryColor,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //         )
                  //       ]),
                  //     ),
                  //     const SizedBox(
                  //       height: 5,
                  //     ),
                  //     Text(e['day'].toString())
                  //   ]),
                  //
                  );
            }).toList()),
      ),
    );
  }
}
