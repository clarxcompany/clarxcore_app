// lib/screens/favorites_page.dart

import 'package:flutter/material.dart';
import 'dart:ui';
import '../main.dart';
import '../widgets/fancy_task_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    const headerHeight = 240.0;

    return Column(
      children: [
        // ——————— HEADER (ikonlar kaldırıldı) ———————
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
          child: SizedBox(
            height: headerHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 1) Background image
                Image.asset(
                  'assets/header_bg.png',
                  fit: BoxFit.cover,
                ),
                // 2) Dark gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
                // 3) Title & actions
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        const Text(
                          'Favoriler',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white70, size: 28),
                          onPressed: () {},
                          tooltip: 'Ara',
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list, color: Colors.white70, size: 28),
                          onPressed: () {},
                          tooltip: 'Filtrele',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ——————— FAVORİLER LİSTESİ ———————
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: bottomPad),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, idx) {
              final items = [
                {
                  'title': 'Sabah Yoga',
                  'completed': 5,
                  'total': 10,
                  'colors': [Color(0xFF42A5F5), Color(0xFF1E88E5)]
                },
                {
                  'title': 'Su Takibi',
                  'completed': 20,
                  'total': 30,
                  'colors': [Color(0xFF66BB6A), Color(0xFF388E3C)]
                },
                {
                  'title': 'Pomodoro',
                  'completed': 1,
                  'total': 4,
                  'colors': [Color(0xFFFFA726), Color(0xFFF57C00)]
                },
              ];
              final item = items[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FancyTaskCard(
                  title: item['title'] as String,
                  completed: item['completed'] as int,
                  total: item['total'] as int,
                  gradient: item['colors'] as List<Color>,
                  onMenu: () => debugPrint('Menu on ${item['title']}'),
                  onAdd: () => debugPrint('Add on ${item['title']}'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
