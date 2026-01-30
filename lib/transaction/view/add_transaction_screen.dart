import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartwheels_task/core/app_colors.dart';
import 'package:smartwheels_task/transaction/view_model/transaction_view_model.dart';
import 'package:smartwheels_task/transaction/widgets/app_dropdown_widget.dart';
import 'package:smartwheels_task/transaction/widgets/app_text_form_field.dart';
import 'package:smartwheels_task/transaction/model/transaction_model.dart';
import 'package:smartwheels_task/transaction/widgets/read_only_field.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  Future<void> _pickDate(TransactionViewModel vm) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: vm.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      vm.setDate(picked);
    }
  }

  Future<void> _save(TransactionViewModel vm) async {
    try {
      await vm.addNewTransaction(
        title: _titleCtrl.text,
        message: _messageCtrl.text,
        amountText: _amountCtrl.text,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _messageCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionViewModel>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text(
          'Add Transaction',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
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
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ReadOnlyField(
                      label: 'Date',
                      value:
                          '${vm.selectedDate.day}/${vm.selectedDate.month}/${vm.selectedDate.year}',
                      icon: Icons.calendar_today,
                      onTap: () => _pickDate(vm),
                    ),
                    const SizedBox(height: 16),

                    AppDropdownWidget(
                      label: 'Transaction Type',
                      value: vm.selectedType == Type.INCOME
                          ? 'Income'
                          : 'Expense',
                      items: const ['Income', 'Expense'],
                      onChanged: (v) {
                        if (v == 'Income') {
                          vm.setType(Type.INCOME);
                        } else {
                          vm.setType(Type.EXPENSE);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    AppDropdownWidget(
                      label: 'Category',
                      value: vm.selectedCategory,
                      items: vm.categories,
                      onChanged: (v) => vm.setCategory(v!),
                    ),
                    const SizedBox(height: 16),

                    AppTextFormField(
                      controller: _amountCtrl,
                      label: 'Amount',
                      hint: 'Enter amount',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16),

                    AppTextFormField(
                      controller: _titleCtrl,
                      label: 'Title',
                      hint: 'e.g. Grocery / Salary',
                    ),
                    const SizedBox(height: 16),

                    AppTextFormField(
                      controller: _messageCtrl,
                      label: 'Message',
                      hint: 'Optional note',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => _save(vm),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
