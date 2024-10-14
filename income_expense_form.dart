import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeExpenseForm extends StatefulWidget {
  final void Function(Map<String, dynamic> transaction) onSubmit;
  final void Function(Map<String, dynamic> savingsTransaction)? onSavingsSubmit;

  const IncomeExpenseForm({
    Key? key,
    required this.onSubmit,
    this.onSavingsSubmit,
  }) : super(key: key);

  @override
  _IncomeExpenseFormState createState() => _IncomeExpenseFormState();
}

class _IncomeExpenseFormState extends State<IncomeExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _customCategoryController = TextEditingController();
  String? _selectedCategory;
  String? _transactionType;
  DateTime? _selectedDateTime;
  bool _isCustomCategory = false; // Track if custom category is selected

  final List<String> _incomeCategories = [
    'Salary',
    'Investment',
    'Freelancing',
    'Rental Income',
    'Dividends',
    'Other', // Added option for custom category
  ];

  final List<String> _expenseCategories = [
    'Food',
    'Transport',
    'Utilities',
    'Entertainment',
    'Healthcare',
    'Other', // Added option for custom category
  ];

  final List<String> _savingsCategories = [
    'General Savings',
    'Emergency Fund',
    'Retirement',
    'Education',
    'Vacation',
    'Other', // Added option for custom category
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _customCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 241, 114),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Select Transaction Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildTransactionTypeSelector(),
              const SizedBox(height: 16),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _transactionTypeButton('Income'),
        const SizedBox(width: 16),
        _transactionTypeButton('Expense'),
        const SizedBox(width: 16),
        _transactionTypeButton('Savings'),
      ],
    );
  }

  Widget _transactionTypeButton(String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _transactionType = type;
          _selectedCategory = null;
          _isCustomCategory = false; // Reset custom category when type changes
          _customCategoryController.clear(); // Clear custom category input
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _transactionType == type ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          type,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTitleField(),
          const SizedBox(height: 16),
          _buildAmountField(),
          const SizedBox(height: 16),
          _buildDateTimePicker(),
          const SizedBox(height: 16),
          _buildCategoryDropdown(),
          const SizedBox(height: 16),
          _buildDescriptionField(),
          const SizedBox(height: 16),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  TextFormField _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Title',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }

  TextFormField _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      decoration: InputDecoration(
        labelText: 'Amount',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an amount';
        }
        final amount = double.tryParse(value);
        if (amount == null || amount <= 0) {
          return 'Please enter a valid amount greater than zero';
        }
        return null;
      },
    );
  }

  Widget _buildDateTimePicker() {
    return GestureDetector(
      onTap: () async {
        _selectedDateTime = await showDateTimePicker(context);
        setState(() {});
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Select Date and Time',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDateTime == null
                  ? 'Select Date and Time'
                  : DateFormat.yMMMd().add_jm().format(_selectedDateTime!),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            labelText: 'Category',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
            ),
          ),
          items: (_transactionType == 'Income'
                  ? _incomeCategories
                  : _transactionType == 'Expense'
                      ? _expenseCategories
                      : _savingsCategories)
              .map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
              _isCustomCategory = newValue == 'Other'; // Check if 'Other' is selected
              if (!_isCustomCategory) {
                _customCategoryController.clear(); // Clear custom input if not 'Other'
              }
            });
          },
          validator: (value) {
            if (value == null && !_isCustomCategory) {
              return 'Please select a category';
            }
            return null;
          },
        ),
        if (_isCustomCategory) // Show input for custom category if selected
          TextFormField(
            controller: _customCategoryController,
            decoration: InputDecoration(
              labelText: 'Enter Custom Category',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category name';
              }
              return null;
            },
          ),
      ],
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: 'Description (max 100 chars)',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
        ),
      ),
      maxLength: 100,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }

  ElevatedButton _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (_selectedDateTime == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a date and time.'),
              ),
            );
            return;
          }

          String title = _titleController.text;
          double amount = double.parse(_amountController.text);
          String description = _descriptionController.text;
          String category = _isCustomCategory ? _customCategoryController.text : _selectedCategory!;
          DateTime dateTime = _selectedDateTime!;

          Map<String, dynamic> transaction = {
            'type': _transactionType,
            'title': title,
            'amount': amount,
            'description': description,
            'category': category,
            'dateTime': dateTime,
          };

          if (_transactionType == 'Savings' && widget.onSavingsSubmit != null) {
            widget.onSavingsSubmit!(transaction);
          } else {
            widget.onSubmit(transaction);
          }

          _clearForm();
        }
      },
      child: const Text('Submit'),
    );
  }

  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    DateTime? pickedDate;
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value != null) {
        pickedDate = value;
      }
    });

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      return combineDateTime(pickedDate, pickedTime);
    }
    return null;
  }

  DateTime? combineDateTime(DateTime? pickedDate, TimeOfDay? pickedTime) {
    if (pickedDate != null && pickedTime != null) {
      return DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    } else {
      return null;
    }
  }

  void _clearForm() {
    _titleController.clear();
    _amountController.clear();
    _descriptionController.clear();
    _customCategoryController.clear();
    _selectedCategory = null;
    _selectedDateTime = null;
    setState(() {
      _transactionType = null;
      _isCustomCategory = false; // Reset custom category
    });
  }
}
