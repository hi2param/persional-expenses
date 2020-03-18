import 'package:flutter/material.dart';
import 'package:personal_expenes_app/chart.dart';
import 'package:personal_expenes_app/new_transaction.dart';
import 'package:personal_expenes_app/transaction.dart';
import 'package:personal_expenes_app/transaction_list.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
       
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
        title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
        ),

        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                fontWeight: FontWeight.bold),
            ),
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

class _MyHomePageState extends State<MyHomePage> {

  final titleController=TextEditingController();
  final amountController=TextEditingController();

final List<Transaction> _userTransactions=[
   /* Transaction(id: 't1', tittle: 'new shoes',
     amount: 69.99, date: DateTime.now(),),
    Transaction(id: 't2', tittle: 'new sleepr', 
    amount: 16.99, date: DateTime.now(),),
    Transaction(id: 't3', tittle: 'new boot',
     amount: 65.65, date: DateTime.now(),),*/
  ];

  List<Transaction> get _recentTransaction{
   return _userTransactions.where((tx)
       {
         return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),
         ),
         );
       }).toList();
}
  void _addNewTransaction(String txTitle, double txAmount, DateTime choseDate){
    final newTx=Transaction(tittle: txTitle,
     amount: txAmount,
      date: choseDate,
      id: DateTime.now().toString(),
    
    );
setState(() {
  _userTransactions.add(newTx);
});
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
       builder: (_){
         return GestureDetector(
           onTap: (){},
           child: NewTransaction(_addNewTransaction),
           behavior: HitTestBehavior.opaque,
           );
           },
    );
  }

  //get horizontal => null;
void _deleteTransaction(String id){
setState(() {
  _userTransactions.removeWhere((tx) =>  tx.id == id);
  
  });
}
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       
       title: Text('Personal Expenses'),
       actions: <Widget>[
         IconButton(icon: Icon(Icons.add),
         onPressed:()=> _startAddNewTransaction(context),
         ),
       ],

   ),
   body: SingleChildScrollView(
        child: Column(
       //mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: <Widget>[
         Chart(_recentTransaction),
            TransactionList(_userTransactions, _deleteTransaction)
       ],
     ),
   ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
   floatingActionButton: FloatingActionButton(
     child: Icon(Icons.add),
     onPressed: ()=> _startAddNewTransaction(context),
     ),
   );
  }
}
