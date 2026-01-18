import 'package:flutter/material.dart';

Widget ingredientSection({
  required String title,
  required List<String> items,
  required Color bgColor,
  required String iconPath, // <-- now a path to your image
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ...items.map(
        (item) => Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(iconPath, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(item),
            ],
          ),
        ),
      ),
    ],
  );
}
