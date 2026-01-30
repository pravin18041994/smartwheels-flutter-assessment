import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartwheels_task/api/transaction_api_services.dart';
import 'package:smartwheels_task/transaction/view/transaction_screen.dart';
import 'package:smartwheels_task/transaction/view_model/transaction_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionViewModel(TransactionApiService()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assessment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TransactionScreen(),
    );
  }
}
