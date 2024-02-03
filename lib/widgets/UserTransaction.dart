import 'package:flutter/material.dart';
import 'NewTransaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          pressChange: (){},
        ),
      ],
    );
  }
}
