import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final double totalSavings;

  const SummaryCard({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalSavings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the contents vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Center the contents horizontally
        children: [
          Text(
            'Summary',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Center the title
          ),
          SizedBox(height: 10),
          Text(
            'Total Income: \$${totalIncome.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.green, fontSize: 18),
            textAlign: TextAlign.center, // Center the income text
          ),
          Text(
            'Total Expense: \$${totalExpense.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center, // Center the expense text
          ),
          Text(
            'Total Savings: \$${totalSavings.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.blue, fontSize: 18),
            textAlign: TextAlign.center, // Center the savings text
          ),
        ],
      ),
    );
  }
}
