import 'package:flutter/material.dart';
import 'dart:io';

import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

import 'scan_results_screen.dart';

import '../widgets/tip_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tips = [
    "Hold your phone steady for a clear scan.",
    "Make sure the entire ingredient list is visible.",
    "Avoid glare by tilting the package slightly.",
    "Zoom in if the text is small, but keep it sharp.",
    "Use good lighting — it helps with accuracy.",
    "Flatten crinkled packaging for better results.",
  ];

  int currentTipIndex = 0;

  Future<void> _scanNow() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image == null) return; // user cancelled

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScanResultsScreen(imageFile: File(image.path)),
      ),
    );
  }

  void _showInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button (top right)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Title
              Text(
                'How to Use This App',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Instructions
              const Text('1. Find a product with an ingredient label.'),
              const SizedBox(height: 8),
              const Text(
                '2. Tap Scan a Label and take a clear photo of the full ingredient list.',
              ),
              const SizedBox(height: 8),
              const Text('3. Wait a moment while the app analyzes it.'),
              const SizedBox(height: 8),
              const Text(
                '4. View the breakdown showing which ingredients are Jain-friendly or not.',
              ),
              const SizedBox(height: 24),

              // Got it button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Got it',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return false;

      setState(() {
        currentTipIndex = (currentTipIndex + 1) % tips.length;
      });

      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // App title
              Text(
                'But is it Jain?',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Lottie animation
              Lottie.asset(
                'assets/lottie/scanning.json',
                height: 320,
                repeat: true,
              ),

              const SizedBox(height: 24),

              // Tip box
              TipBox(tip: tips[currentTipIndex], index: currentTipIndex),

              const Expanded(child: SizedBox()),

              // ===== SCAN BUTTON & INFO ICON =====
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    // Scan Now button expands to fill remaining space
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _scanNow,
                        child: const Text(
                          'Scan Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Info icon button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.info_outline,
                          color: Color(0xFFE53935), // accent color
                        ),
                        onPressed: () => _showInfoModal(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
