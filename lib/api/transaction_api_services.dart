import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartwheels_task/core/app_constants.dart';
import 'package:smartwheels_task/transaction/model/transaction_model.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class TransactionApiService {
  Future<TransactionResponseModel> fetchTransactions() async {
    try {
      final response = await http
          .get(Uri.parse(AppConstants.apiUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw ApiException('Server error: ${response.statusCode}');
      }
      debugPrint(response.body);

      return transactionResponseModelFromJson(response.body);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network/Parsing error: $e');
    }
  }

  Future<void> saveTransaction(Transaction tx) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
    } catch (e) {
      throw ApiException('Failed to save transaction');
    }
  }
}
