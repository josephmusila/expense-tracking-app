import 'package:flutter/material.dart';
import 'package:quiz/views/transactionList.dart';

import '../transaction.dart';
import 'newTransaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
       
       // NewTransaction(_addTransaction) ,

      ],
    );
  }
}
