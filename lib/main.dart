import 'package:flutter/material.dart';
import 'package:round_1/screens/financing_widget.dart';
import 'package:round_1/widgets/financing_card.dart';
import 'package:round_1/widgets/financing_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, dynamic> results = {
    'revenue_amount': 250000.0,
    'funding_amount': 0.0,
    'fees_percentage': 0.0,
    'desired_fee_percentage': 0.0,
    'repayment_delay': '30 days',
    'payment_frequency': 'weekly',
  };

  void recompute(key, value) {
    setState(() {
      results[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'NED: Finance Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FinanceScreen(
          leftWidget: FinanceForm(updateResults: recompute, results: results),
          rightWidget: FinanceCard(results: results)),
    );
  }
}
