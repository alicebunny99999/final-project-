import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transactions; // Accept transactions from HomeScreen
  final List<Map<String, dynamic>> savingsTransactions; // Accept savings transactions
  final Function(double totalIncome, double totalExpense) onTotalsCalculated; // Callback to send totals

  const TransactionScreen({
    Key? key,
    required this.transactions,
    required this.savingsTransactions, // Added savings transactions parameter
    required this.onTotalsCalculated, // Add the callback parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Separate income and expense transactions
    final incomeTransactions = transactions.where((transaction) => transaction['type'] == 'Income').toList();
    final expenseTransactions = transactions.where((transaction) => transaction['type'] == 'Expense').toList();

    // Calculate total income and expense
    final totalIncome = incomeTransactions.fold(0.0, (sum, transaction) => sum + transaction['amount']);
    final totalExpense = expenseTransactions.fold(0.0, (sum, transaction) => sum + transaction['amount']);

    // Call the callback to pass totals to HomeScreen
    onTotalsCalculated(totalIncome, totalExpense);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Transactions',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Income Transactions
          const Text(
            'Income',
            style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: incomeTransactions.length,
              itemBuilder: (context, index) {
                final transaction = incomeTransactions[index];
                return Card(
                  color: Colors.green[200],
                  child: ListTile(
                    title: Text(transaction['title']),
                    subtitle: Text(
                      '${transaction['description']} - ${transaction['category']} - ${DateFormat.yMMMd().add_jm().format(transaction['dateTime'])}',
                    ),
                    trailing: Text('\$${transaction['amount']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Expense Transactions
          const Text(
            'Expenses',
            style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: expenseTransactions.length,
              itemBuilder: (context, index) {
                final transaction = expenseTransactions[index];
                return Card(
                  color: Colors.red[200],
                  child: ListTile(
                    title: Text(transaction['title']),
                    subtitle: Text(
                      '${transaction['description']} - ${transaction['category']} - ${DateFormat.yMMMd().add_jm().format(transaction['dateTime'])}',
                    ),
                    trailing: Text('\$${transaction['amount']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Savings Transactions
          const Text(
            'Savings',
            style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: savingsTransactions.length,
              itemBuilder: (context, index) {
                final transaction = savingsTransactions[index];
                return Card(
                  color: Colors.blue[200],
                  child: ListTile(
                    title: Text(transaction['title']),
                    subtitle: Text(
                      '${transaction['description']} - ${transaction['category']} - ${DateFormat.yMMMd().add_jm().format(transaction['dateTime'])}',
                    ),
                    trailing: Text('\$${transaction['amount']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
