import 'package:flutter/material.dart';
import 'package:personal_expensive/model/transaction.dart';
import 'package:personal_expensive/widget/cart.dart';
import 'package:personal_expensive/widget/new_transaction.dart';
import 'package:personal_expensive/widget/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  
  void _deleteTransation(String id) {
    setState(() {   
    _userTransactions.removeWhere((element) {
      return element.id == id;
    });
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTx: addNewTransaction),
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date!.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Expensive',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Cart(recentTransactions: _recentTransactions),
            TransactionList(transactions: _userTransactions, deleteTransation: _deleteTransation,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            setState(() {
              startAddNewTransaction(context);
            });
          },
          child: Icon(
            Icons.add,
            // color: Theme.of(context).primaryColor,
          )),
    );
  }
}
