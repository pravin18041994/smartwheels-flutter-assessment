# SmartWheels Transaction App (Flutter Assessment)

This project is a Flutter-based transaction management application developed as part of the SmartWheels technical assessment.

The app demonstrates clean MVVM architecture, API integration, and a modern UI for managing income and expense transactions.

---

## ✨ Features

- Transaction summary (Total Balance, Income, Expense)
- Month-wise grouped transaction list
- Switch between Income & Expense
- Add new transaction with date, category, and type
- Real-time UI update after saving transaction
- Clean MVVM architecture using Provider
- API integration for fetching and saving transactions
- Loading and error state handling

---

## 🏗 Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture:

- **Model**: Data models generated using QuickType
- **View**: Flutter UI screens and reusable widgets
- **ViewModel**: Business logic, API calls, and state management
- **Service Layer**: API service for network requests

State management is handled using **Provider**.

---

## 📁 Project Structure

```text
lib/
├── api/
│   └── transaction_api_services.dart
├── core/
│   └── app_colors.dart
├── transaction/
│   ├── model/
│   │   └── transaction_model.dart
│   ├── view/
│   │   ├── transaction_screen.dart
│   │   └── add_transaction_screen.dart
│   ├── view_model/
│   │   └── transaction_view_model.dart
│   └── widgets/
│       ├── summary_card.dart
│       ├── transaction_list_item.dart
│       ├── app_dropdown_widget.dart
│       ├── app_text_form_field.dart
│       └── app_bottom_nav_bar.dart

🚀 Setup Instructions
Prerequisites
Flutter SDK (latest stable)

Android Studio or VS Code

Android Emulator or Physical Device

Steps to Run

Clone the repository:

git clone https://github.com/pravin18041994/smartwheels-flutter-assessment.git

cd smartwheels-flutter-assessment

Install dependencies:

flutter pub get
Run the app:

flutter run
🔌 API Configuration
The app integrates with an API using the service layer:

TransactionApiService
Ensure the API base URL is correctly configured in:

lib/api/transaction_api_services.dart

## Screen Recording (Demo)

The screen recording demonstrates:

- Transaction screen
- Switching between Income & Expense
- Adding a transaction
- State update after saving transaction

### Video Link

```

https://drive.google.com/file/d/13YctbySwc1lCSFdJdOSvTJlCwxOjBU9K/view?usp=sharing

```

Repository Link
https://github.com/pravin18041994/smartwheels-flutter-assessment.git


## Tested Scenarios

- Fetching transactions from API
- Month-wise grouping of transactions
- Adding new income and expense transactions
- Updating summary after saving
- Handling loading and error states

## Tech Stack

- Flutter
- Dart
- Provider (State Management)
- REST API Integration
- MVVM Architecture



```
