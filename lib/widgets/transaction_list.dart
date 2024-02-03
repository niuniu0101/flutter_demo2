import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList({required this.transaction, required this.deleteTx});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text("\$${transaction[index].amout}"),
                      )
                  )
              ),
              title: Text(transaction[index].title),
              subtitle: Text(
                DateFormat.yMMMd().format(transaction[index].date),
              ),
              trailing: IconButton(onPressed:() => deleteTx(transaction[index].id),
                icon: Icon(Icons.delete,color: Colors.pinkAccent,),

              ),
            )
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
