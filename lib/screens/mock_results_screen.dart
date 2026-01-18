//import 'dart:io';
import 'package:flutter/material.dart';
import '../models/scan_result.dart';
import '../widgets/ingredient_section.dart';

class MockResultsScreen extends StatelessWidget {
  const MockResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock image - you can replace with any image in assets
    //final File mockImage = File('assets/mock_label.png');

    // Mock ScanResult
    final ScanResult mockResult = ScanResult(
      jain: ['Milk', 'Sugar', 'Rice'],
      nonJain: ['Gelatin', 'Honey'],
      uncertain: ['Natural Flavors', 'Enzymes'],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scan Results',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mock image at top
            //Center(
            //  child: Image.file(mockImage, height: 250, fit: BoxFit.contain),
            //),
            const SizedBox(height: 24),

            // Mock results
            ingredientSection(
              title: 'Non-Jain',
              items: mockResult.nonJain,
              bgColor: Colors.red.shade100,
              iconPath: 'assets/nonjainicon.png',
            ),

            ingredientSection(
              title: 'Uncertain',
              items: mockResult.uncertain,
              bgColor: Colors.yellow.shade100,
              iconPath: 'assets/uncertainicon.png',
            ),

            ingredientSection(
              title: 'Jain',
              items: mockResult.jain,
              bgColor: Colors.green.shade100,
              iconPath: 'assets/jainicon.png',
            ),
          ],
        ),
      ),
    );
  }
}
