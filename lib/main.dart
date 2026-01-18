import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
//import 'screens/mock_results_screen.dart';

void main() {
  runApp(const ButIsItJainApp());
}

class ButIsItJainApp extends StatelessWidget {
  const ButIsItJainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'But Is It Jain?',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
