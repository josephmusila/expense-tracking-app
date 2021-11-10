import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/transaction.dart';
import 'package:intl/intl.dart';
import 'package:quiz/views/chart.dart';
import 'package:quiz/views/newTransaction.dart';
import 'package:quiz/views/transactionList.dart';
import 'package:quiz/views/userTransaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber
            )
          )
      )

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> transactions=[
    /*Transaction(id: "t1", title: "New shoes", amount: 23.01, date: DateTime.now()),
    Transaction(id: "t2", title: "Rent", amount: 85.99, date: DateTime.now()),*/
  ];

  void _addTransaction(String txTitle,double txAmount,DateTime choseDate){
    final newTx=Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: choseDate);
    setState(() {
      transactions.add(newTx);
    });
  }
  void deleteTransaction(String id){
      transactions.removeWhere((element) => element.id==id);
  }

  void startAddNewTransaction(BuildContext ctxt){
    showModalBottomSheet(context: ctxt, builder: (bctx){
      return GestureDetector(
          onTap: (){},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addTransaction));
    },);
  }
  bool _showChart=false;


  @override
  void initState() {
   WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifeCycleState(AppLifecycleState state){
    print(state);
  }
  @override
  dispose(){
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  List<Transaction>? get _recentTransactions{
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7),),
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    final isLandsCape=MediaQuery.of(context).orientation==Orientation.landscape;
    final  appBar=AppBar(
      title: Text("EXPENSES"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: ()=>startAddNewTransaction(context),
        )
      ],
    );
    final txListWidget=Container(
        height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)* 0.7,
        child: TransactionList(transactions,deleteTransaction));
    final pageBody=SafeArea(child:   SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandsCape)Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Show Chart"),
              Switch.adaptive(
                value: _showChart,
                onChanged: (val){
                  setState(() {
                    _showChart=val;
                  });
                },
              )
            ],
          ),
          if(!isLandsCape)
            Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)* 0.3,
                child: Chart(_recentTransactions!)),
          if(!isLandsCape)txListWidget,
          if(isLandsCape)_showChart?Container(
              height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)* 0.7,
              child: Chart(_recentTransactions!)):
          txListWidget,

        ],
      ),
      ),
    );
   return Platform.isIOS?CupertinoPageScaffold(child: pageBody) :Scaffold(
     appBar: appBar,
     body:pageBody,
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     floatingActionButton:Platform.isIOS? Container(): FloatingActionButton(
       child: Icon(Icons.add),
       onPressed: ()=>startAddNewTransaction(context),
     ),
   );
  }
}


