import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double? spendingAmount;
  final double? spendingPctOfTotal;
  final String? label;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 20,
        child:
            FittedBox(child: Text('\$${spendingAmount!.toStringAsFixed(0)}')),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        height: 100,
        width: 15,
        // decoration: BoxDecoration(
        //     color: Colors.grey, borderRadius: BorderRadius.circular(5)),
        child: Stack(children: [
          Container(
            // height: 30,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1.0),
              color: const Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            heightFactor: spendingPctOfTotal,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ]),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(label!),
    ]);
  }
}
