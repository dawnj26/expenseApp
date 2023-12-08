import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/expense_card.dart';
import '../models/expenses.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];
  var item = TextEditingController();
  var desc = TextEditingController();
  var amount = TextEditingController();
  void addItem() {
    String errMsg = "";
    double? amnt = double.tryParse(amount.text);

    if (item.text.isEmpty) {
      errMsg = "Item must not be empty";
      showErrMsg(errMsg);
      return;
    }
    if (desc.text.isEmpty) {
      errMsg = "Description must not be empty";
      showErrMsg(errMsg);
      return;
    }

    if (amnt == null || amnt <= 0) {
      errMsg = "Amount must be a number and must be greater than 0";
      showErrMsg(errMsg);
      return;
    }
    setState(() {
      expenses.insert(0, Expense(item.text, desc.text, amnt));
      item.clear();
      desc.clear();
      amount.clear();
    });
  }


  void removeItem(Expense item) {
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: const Text('Warning'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(onPressed: (){
            setState(() {
              expenses.remove(item);
              Navigator.of(context).pop();
            });
          }, child: const Text('Yes')),
          ElevatedButton(onPressed: (){
            setState(() {
              Navigator.of(context).pop();
            });
          }, child: const Text('No')),
        ],
      );
    });
  }

  void showErrMsg(String msg) {
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: const Text('Warning'),
        content: Text(msg),
        actions: [
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ok')),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: item,
                      decoration: const InputDecoration(
                        label: Text('Expense item'),
                      ),
                    ),
                    const Gap(8.0),
                    TextField(
                      controller: desc,
                      decoration: const InputDecoration(
                        label: Text('Description'),
                      ),
                    ),
                    const Gap(8.0),
                    TextField(
                      controller: amount,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                      ),
                    ),
                    const Gap(8.0),
                    ElevatedButton(onPressed: addItem, child: const Text('Add'))
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) => ExpenseCard(item: expenses[index], removeItem: removeItem,),
                itemCount: expenses.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
