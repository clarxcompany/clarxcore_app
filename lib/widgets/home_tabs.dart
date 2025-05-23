// lib/widgets/home_tabs.dart

import 'package:flutter/material.dart';
import '../main.dart';
import 'fancy_task_card.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _sectionHeader('İlerleme', ClarxCoreApp.primaryColor),
          FancyTaskCard(
            title: 'Holidays in Norway',
            completed: 8,
            total: 10,
            gradient: const [Color(0xFF42A5F5), Color(0xFF1E88E5)],
            onMenu: () => debugPrint('Menu tapped'),
            onAdd: () => debugPrint('Add tapped'),
          ),
          FancyTaskCard(
            title: 'Daily Tasks',
            completed: 2,
            total: 4,
            gradient: const [Color(0xFFFDD835), Color(0xFFFBC02D)],
            onMenu: () => debugPrint('Menu tapped'),
            onAdd: () => debugPrint('Add tapped'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, Color accent) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
    child: Row(
      children: [
        Container(width: 4, height: 28, color: accent),
        const SizedBox(width: 8),
        Text(title,
            style: TextStyle(
                color: accent, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
