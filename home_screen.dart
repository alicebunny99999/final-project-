import 'package:flutter/material.dart';
import 'income_expense_form.dart'; // Import form for entering income/expense data
import 'transaction_screen.dart'; // Import Transaction page
import 'savings_screen.dart'; // Import Savings page
import 'summary_card.dart'; // Import SummaryCard

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Variable to hold the index of the selected button
  List<Map<String, dynamic>> _transactions = []; // List to hold transaction data
  List<Map<String, dynamic>> _savingsTransactions = []; // List to hold savings transactions

  // Titles for each screen
  final List<String> _titles = [
    'Home',
    'Transaction',
    'Savings',
    'Settings',
  ];

  // Function to change page when a button is tapped in BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Change index when tapped
    });
  }

  // Function to add a transaction
  void _addTransaction(Map<String, dynamic> transaction) {
    setState(() {
      _transactions.add(transaction); // Add new transaction to the list
    });
  }

  // Function to add a savings transaction
  void _addSavingsTransaction(Map<String, dynamic> savingsTransaction) {
    setState(() {
      _savingsTransactions.add(savingsTransaction); // Add new savings transaction to the list
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total income, expense, and savings
    double totalIncome = _transactions
        .where((tx) => tx['type'] == 'Income') // Ensure 'Income' matches the type used in Transaction
        .fold(0.0, (sum, tx) => sum + tx['amount']);
    double totalExpense = _transactions
        .where((tx) => tx['type'] == 'Expense') // Ensure 'Expense' matches the type used in Transaction
        .fold(0.0, (sum, tx) => sum + tx['amount']);
    double totalSavings = _savingsTransactions.fold(0.0, (sum, tx) => sum + tx['amount']); // Total savings calculation

    // Display the selected page based on index
    List<Widget> _screens = [
      Center( // Center the SummaryCard
        child: SummaryCard(
          totalIncome: totalIncome,
          totalExpense: totalExpense,
          totalSavings: totalSavings,
        ),
      ),
      TransactionScreen(
        transactions: _transactions, // Pass transaction list
        savingsTransactions: _savingsTransactions, onTotalsCalculated: (double totalIncome, double totalExpense) {  },
      ),
      SavingsScreen(
        savingsTransactions: _savingsTransactions, // Pass savings transactions to SavingsScreen
      ),
      Center(child: Text('Settings Screen', style: const TextStyle(color: Colors.white, fontSize: 24))),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]), // Change title based on selected index
      ),
      body: _screens[_selectedIndex], // Show page based on selected index
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/icon_home.png', // Image for Home item
              width: 30,
              height: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/icon_transfer.png', // Image for Transaction item
              width: 40,
              height: 40,
            ),
            label: 'Transaction', // Changed name from History to Transaction
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/icon_piggy_savings.png', // Image for Savings item
              width: 40,
              height: 40,
            ),
            label: 'Savings',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/icon_setting.png', // Image for Settings item
              width: 30,
              height: 30,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex, // Show the selected index
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black, // Change the background color of BottomNavigationBar
        onTap: _onItemTapped, // Call the function when a button is tapped
        type: BottomNavigationBarType.fixed, // Use fixed type to keep buttons in a specific position
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0), // Set padding from right and bottom edges
        child: FloatingActionButton(
          onPressed: () {
            // Show modal bottom sheet when button is pressed
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IncomeExpenseForm(
                    onSubmit: _addTransaction, // Pass the onSubmit callback for regular transactions
                    onSavingsSubmit: _addSavingsTransaction, // Pass the onSavingsSubmit callback for savings transactions
                  ),
                );
              },
            );
          },
          backgroundColor: const Color.fromARGB(37, 255, 255, 255), // Set the background color to be transparent
          elevation: 0, // No shadow
          child: Container(
            width: 45, // Size of the button
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Make the button circular
            ),
            child: ClipOval(
              child: Image.asset(
                'images/icon_addDATA3.png', // Path to image
                fit: BoxFit.cover, // Adjust the image to fit the Container
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position of the button
    );
  }
}
