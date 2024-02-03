import 'package:flutter/material.dart';
import 'package:recordcost/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:recordcost/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.day == weekday.day) {
          totalSum += recentTransactions[i].amout;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        "amout": totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return (sum as double) + (item['amout'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'] as String,
                      data["amout"] as double,
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amout'] as double) / totalSpending));
            }).toList(),
          ),
        ));
  }
}
