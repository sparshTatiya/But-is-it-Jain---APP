import 'dart:io';

import 'package:flutter/material.dart';

import '../models/scan_result.dart';
import '../services/api_service.dart';
import '../widgets/ingredient_section.dart';

class ScanResultsScreen extends StatefulWidget {
  final File imageFile;

  const ScanResultsScreen({super.key, required this.imageFile});

  @override
  State<ScanResultsScreen> createState() => _ScanResultsScreenState();
}

class _ScanResultsScreenState extends State<ScanResultsScreen> {
  bool isLoading = true;
  ScanResult? result;
  String? error;

  @override
  void initState() {
    super.initState();
    _runScan();
  }

  Future<void> _runScan() async {
    try {
      final response = await ApiService.classifyImage(widget.imageFile);

      if (!mounted) return;

      if (response.jain.isEmpty &&
          response.nonJain.isEmpty &&
          response.uncertain.isEmpty) {
        throw Exception(
          'Hmm... Something seems wrong, maybe try rescanning the ingredient label.',
        );
      }

      setState(() {
        result = response;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            // Image preview
            Center(
              child: Image.file(
                widget.imageFile,
                height: 350,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 24),

            // Loading state
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),

            // Error state
            if (!isLoading && error != null)
              Center(
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),

            // Results
            if (!isLoading && result != null) ...[
              ingredientSection(
                title: 'Non-Jain',
                items: result!.nonJain,
                bgColor: Colors.red.shade100,
                iconPath: 'assets/nonjainicon.png',
              ),

              ingredientSection(
                title: 'Uncertain',
                items: result!.uncertain,
                bgColor: Colors.yellow.shade100,
                iconPath: 'assets/uncertainicon.png',
              ),

              ingredientSection(
                title: 'Jain',
                items: result!.jain,
                bgColor: Colors.green.shade100,
                iconPath: 'assets/jainicon.png',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
