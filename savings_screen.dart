import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class SavingsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> savingsTransactions; // Accepting a list of savings transactions

  const SavingsScreen({Key? key, required this.savingsTransactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color for contrast
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Savings History',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0), // Space between title and list
            Expanded(
              child: ListView.builder(
                itemCount: savingsTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = savingsTransactions[index];

                  // Display only the title, dateandtime, and amount fields
                  final title = transaction['title'] ?? 'No title available';
                  final dateAndTimeString = transaction['dateandtime'] ?? 'No date available';
                  final amount = transaction['amount'] ?? 'No amount available';

                  // Parse the dateAndTime string into a DateTime object
                  DateTime dateAndTime;
                  try {
                    dateAndTime = DateTime.parse(dateAndTimeString);
                  } catch (e) {
                    dateAndTime = DateTime.now(); // Fallback to current time if parsing fails
                  }

                  // Format the date and time
                  final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateAndTime);

                  return ListTile(
                    title: Text(
                      'Title: $title',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date and Time: $formattedDate', // Display formatted date and time
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Amount: \$${amount.toString()}', // Display amount
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
