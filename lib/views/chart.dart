import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz/transaction.dart';
import 'package:quiz/views/chartBars.dart';

class Chart extends StatelessWidget {
  late final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get getGroupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0,1),
        'amount':totalSum ,
      };
    }).reversed.toList();
  }
    double get spendingAmount{
      return getGroupedTransactionValues.fold(0.0, (sum, item) {
        return sum  + double.parse(item['amount'].toString());
      });
}
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: getGroupedTransactionValues.map((data){
          return ChartBar(data['day'].toString(), data['amount'] as double, spendingAmount== 0.0? 0.0 : (data['amount'] as double)/spendingAmount);
        }).toList(),
      ),
    );
  }
}
