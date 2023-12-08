import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../models/expenses.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({Key? key, required this.item, required this.removeItem}) : super(key: key);

  final void Function(Expense item) removeItem;
  final Expense item;
  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.currency(locale: "en_us" ,decimalDigits: 2, name: "₱");
    String amount = f.format(item.amount);
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4.0)
        ),
        padding: const EdgeInsets.only(left: 16.0),
        child: const Icon(Icons.delete, color: Colors.white,),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => removeItem(item),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.item, style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),),
                  const Gap(4.0),
                  Text(item.description),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text(amount, style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
