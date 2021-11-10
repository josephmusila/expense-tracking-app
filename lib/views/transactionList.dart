import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? LayoutBuilder(

            builder: (context, constraints) {
              return Column(
                  children: [
                    Text(
                      "No transactions added yet !!",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: constraints.maxHeight*0.6,
                        child: Image.asset(
                          "assets/images/waiting.png",
                          fit: BoxFit.cover,
                        )),
                  ],
                );
            }
          )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text("\$${transactions[index].amount}")),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing:MediaQuery.of(context).size.width >300? TextButton.icon(

                        icon: Icon(Icons.delete),
                        onPressed: (){
                          deleteTx(transactions[index].id);
                        },
                        label: Text("Delete"),):
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed:(){
                        deleteTx(transactions[index].id);
                      } ,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
