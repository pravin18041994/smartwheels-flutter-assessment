import 'package:flutter/material.dart';
import 'package:smartwheels_task/api/transaction_api_services.dart';
import 'package:smartwheels_task/transaction/model/transaction_model.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionApiService _apiService;

  TransactionViewModel(this._apiService);

  bool isLoading = false;
  String? errorMessage;

  Summary? _summary;
  final List<Transaction> _transactions = [];

  Summary? get summary => _summary;
  List<Transaction> get transactions => List.unmodifiable(_transactions);

  DateTime selectedDate = DateTime.now();
  String selectedCategory = 'Food';
  Type selectedType = Type.EXPENSE;

  final List<String> categories = const [
    'Food',
    'Salary',
    'Project',
    'Shopping',
    'Travel',
    'Bills',
  ];

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  void setType(Type value) {
    selectedType = value;
    notifyListeners();
  }

  void resetAddForm() {
    selectedDate = DateTime.now();
    selectedCategory = 'Food';
    selectedType = Type.EXPENSE;
    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final response = await _apiService.fetchTransactions();
      _summary = response.data.summary;
      _transactions
        ..clear()
        ..addAll(response.data.transactions);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(Transaction tx) async {
    await _apiService.saveTransaction(tx);
    _transactions.insert(0, tx);
    if (_summary != null) {
      final isIncome = tx.type == Type.INCOME;
      _summary = Summary(
        totalBalance:
            _summary!.totalBalance + (isIncome ? tx.amount : -tx.amount),
        totalIncome: _summary!.totalIncome + (isIncome ? tx.amount : 0),
        totalExpense: _summary!.totalExpense + (isIncome ? 0 : tx.amount),
      );
    }

    notifyListeners();
  }

  Future<void> addNewTransaction({
    required String title,
    required String message,
    required String amountText,
  }) async {
    final amount = int.tryParse(amountText);
    if (amount == null || amount <= 0) {
      throw Exception('Enter valid amount');
    }
    if (title.trim().isEmpty) {
      throw Exception('Title is required');
    }

    final tx = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: selectedType,
      title: title.trim(),
      message: message.trim(),
      amount: amount,
      date: selectedDate,
    );
    await addTransaction(tx);
    resetAddForm();
  }

  Map<String, List<Transaction>> get groupedTransactionsByMonth {
    final sorted = List<Transaction>.from(_transactions)
      ..sort((a, b) => b.date.compareTo(a.date));
    final Map<String, List<Transaction>> grouped = {};
    for (final tx in sorted) {
      final key = _monthYearLabel(tx.date);
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(tx);
    }

    for (final entry in grouped.entries) {
      entry.value.sort((a, b) => b.date.compareTo(a.date));
    }

    return grouped;
  }

  String _monthYearLabel(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.year}';
  }
}
