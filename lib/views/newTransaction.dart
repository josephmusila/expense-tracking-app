import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void showDatePickerModel() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                /*onChanged: (value){
                     inputTitle=value;
                   },*/
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                /*onChanged: (value){
                       inputAmount=value;
                     },*/
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_selectedDate == null
                            ? "No Date Chosen!!"
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
                    Platform.isIOS? CupertinoButton(onPressed: () {
                      showDatePickerModel();
                    },
                        child: Text("Choose Date")):
                    ElevatedButton(
                        onPressed: () {
                          showDatePickerModel();
                        },
                        child: Text("Choose Date"))
                  ],
                ),
              ),
              TextButton(
                child: Text("Add transaction"),
                onPressed: () {
                  submitData();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
