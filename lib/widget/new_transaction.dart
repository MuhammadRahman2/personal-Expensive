import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expensive/model/transaction.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({this.addTx});
  final Function? addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  List<Transaction>? transaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text.toString();
    final enteredAmount = double.parse(amountController.text.toString());
    // final selectDate = DateTime.now();
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx!(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'title'),
              onSubmitted: ((value) {
                submitData();
              }),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'amout'),
              onSubmitted: ((value) {
                submitData();
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                ),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                    onPressed: _presentPicker, child: const Text('Choose Data')),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: submitData, child: const Text('Add List')),
            )
          ],
        ),
      ),
    );
  }
}
