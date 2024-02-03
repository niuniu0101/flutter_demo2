import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function pressChange;

  NewTransaction({required this.pressChange});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amoutController = TextEditingController();

  DateTime? _selectedDate;

  // 把一系列的变化变成一个函数
  void submitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amoutController.text);
    // 直接放函数进来
    // 检查一下
    if (enterTitle.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return; // 直接返回
    }
    widget.pressChange(enterTitle, enterAmount,_selectedDate);

    Navigator.of(context).pop(); // 关闭这个页面
  }

  void _PresentDatePicker() {
    showDatePicker(
            // 返回一个Future
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "amout"),
                controller: amoutController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(_selectedDate == null
                        ? 'No Data Chosen'
                        : DateFormat.yMd().format(_selectedDate!)),
                    TextButton(
                        onPressed: _PresentDatePicker,
                        child: Text("choose Date"))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text(
                  "add Transaction",
                  style: TextStyle(color: Colors.purple),
                ),
              )
            ],
          ),
        ));
  }
}
