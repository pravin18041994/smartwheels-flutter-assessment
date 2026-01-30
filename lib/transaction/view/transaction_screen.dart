import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartwheels_task/core/app_colors.dart';
import 'package:smartwheels_task/transaction/view/add_transaction_screen.dart';
import 'package:smartwheels_task/transaction/view_model/transaction_view_model.dart';
import 'package:smartwheels_task/transaction/widgets/app_bottom_nav_bar.dart';
import 'package:smartwheels_task/transaction/widgets/summary_card.dart';
import 'package:smartwheels_task/transaction/widgets/transaction_list_item.dart';
import 'package:smartwheels_task/transaction/model/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionViewModel>().fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionViewModel>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textPrimary),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
        },
      ),

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text(
          'Transaction',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SummaryCard(
              title: 'Total Balance',
              amount: '\$${vm.summary?.totalBalance ?? 0}',
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Income',
                    amount: '\$${vm.summary?.totalIncome ?? 0}',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SummaryCard(
                    title: 'Expense',
                    amount: '\$${vm.summary?.totalExpense ?? 0}',
                    backgroundColor: AppColors.expenseBlue,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
              child: _buildList(vm),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(TransactionViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Text(
          vm.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    final grouped = vm.groupedTransactionsByMonth;

    if (grouped.isEmpty) {
      return const Center(
        child: Text(
          'No transactions yet',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView(
      children: grouped.entries.map((entry) {
        final month = entry.key;
        final txList = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                month,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...txList.map((tx) {
              return TransactionListItem(
                title: tx.title,
                time: _formatTime(tx.date),
                category: tx.message,
                type: tx.type == Type.INCOME ? 'Income' : 'Expense',
                amount: tx.amount.toDouble(),
              );
            }).toList(),
          ],
        );
      }).toList(),
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }
}
