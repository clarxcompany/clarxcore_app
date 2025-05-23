// lib/widgets/fancy_task_card.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../main.dart';

class FancyTaskCard extends StatelessWidget {
  final String title;
  final int completed;
  final int total;
  final List<Color> gradient;
  final VoidCallback? onAdd;
  final VoidCallback? onMenu;

  const FancyTaskCard({
    Key? key,
    required this.title,
    required this.completed,
    required this.total,
    required this.gradient,
    this.onAdd,
    this.onMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratio = total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;
    const cardHeight = 180.0;
    const borderRadius = 24.0;
    const sliderW = 20.0;
    const sliderH = 80.0;
    const menuSize = 48.0;
    const addSize = 56.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1) Gradient arka plan
            Container(
              height: cardHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // 2) Stripe overlay
            CustomPaint(
              size: Size(double.infinity, cardHeight),
              painter: StripePainter(
                color: Colors.white.withOpacity(0.1),
                spacing: 6,
                thickness: 2,
              ),
            ),

            // 3) Glitch daireleri
            Positioned(
              top: -40, left: -40,
              child: _buildGlitchCircle(140, Colors.white.withOpacity(0.2)),
            ),
            Positioned(
              bottom: -50, right: -50,
              child: _buildGlitchCircle(160, Colors.white.withOpacity(0.15)),
            ),

            // 4) İçerik + slider
            SizedBox(
              height: cardHeight,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    // Slider
                    Container(
                      width: sliderW,
                      height: sliderH,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(sliderW/2),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: sliderW,
                          height: sliderH * ratio,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(sliderW/2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Metin
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text('$completed/$total',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              const Text('tasks',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14)),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),

                    // Sağda ekle butonuna yer aç
                    const SizedBox(width: addSize),
                  ],
                ),
              ),
            ),

            // 5) Menü butonu (sol alt)
            Positioned(
              bottom: -menuSize/2,
              left: 24,
              child: GestureDetector(
                onTap: onMenu,
                child: Container(
                  width: menuSize,
                  height: menuSize,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.more_horiz, color: Colors.white),
                ),
              ),
            ),

            // 6) Ekle butonu (sağ alt)
            Positioned(
              bottom: -addSize/2,
              right: 24,
              child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: addSize,
                  height: addSize,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add,
                      color: ClarxCoreApp.primaryColor, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlitchCircle(double size, Color color) => ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    ),
  );
}

/// Yatay çizgiler çizen painter
class StripePainter extends CustomPainter {
  final Color color;
  final double spacing;
  final double thickness;

  StripePainter({
    required this.color,
    this.spacing = 6,
    this.thickness = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, thickness),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StripePainter old) =>
      old.color != color ||
          old.spacing != spacing ||
          old.thickness != thickness;
}
