import 'package:flutter/material.dart';
class Transaction {
  final String title;
  final double amount;
  final String category;
  final String description;
  final DateTime dateTime;
  final String type; // "Income" or "Expense"

  Transaction({
    required this.title,
    required this.amount,
    required this.category,
    required this.description,
    required this.dateTime,
    required this.type,
  });
}
class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
