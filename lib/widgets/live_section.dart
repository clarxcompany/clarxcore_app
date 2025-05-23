// lib/widgets/live_section.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/active_page.dart'; // ActivePage'yi import ettik

class LiveSection extends StatefulWidget {
  const LiveSection({Key? key}) : super(key: key);

  @override
  _LiveSectionState createState() => _LiveSectionState();
}

class _LiveSectionState extends State<LiveSection> {
  static const double _cardHeight = 300;
  static const double _sectionPadding = 24;
  static const double _verticalSpacing = 16;
  static const double _borderRadius = 28;
  static const double _accentLarge = 160;
  static const double _accentSmall = 180;
  static const double _iconLarge = 36;
  static const double _buttonPaddingH = 40;
  static const double _buttonPaddingV = 20;

  final PageController _pageController = PageController(viewportFraction: 1.0);

  final List<Map<String, dynamic>> _items = const [
    {
      'title': 'Sabah Yoga',
      'subtitle': 'Esneme ve nefes',
      'icon': Icons.self_improvement,
      'time': '07:00',
      'parts': 23,
      'color': Colors.teal,
    },
    {
      'title': 'Su Takibi',
      'subtitle': 'Gün boyu su iç',
      'icon': Icons.water_drop,
      'time': '00:00',
      'parts': 120,
      'color': Colors.blueAccent,
    },
    {
      'title': 'Pomodoro',
      'subtitle': '25 dk odak',
      'icon': Icons.timer,
      'time': '09:00',
      'parts': 50,
      'color': Colors.deepOrange,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: _verticalSpacing),
        SizedBox(
          height: _cardHeight + _verticalSpacing * 2,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: _items.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: _verticalSpacing),
              child: _buildLiveCard(_items[i]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final color = ClarxCoreApp.primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _sectionPadding),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AKTİF',
                style: TextStyle(
                  color: color,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // Tümünü Gör → ActivePage'e yönlendir
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ActivePage()),
              );
            },
            child: Row(
              children: [
                Text(
                  'Tümünü Gör',
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveCard(Map<String, dynamic> item) {
    final cardColor = item['color'] as Color;
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: _cardHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(color: Colors.white24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              _buildAccent(cardColor.withOpacity(0.3), _accentLarge,
                  top: -40, left: -40),
              _buildAccent(cardColor.withOpacity(0.2), _accentSmall,
                  bottom: -50, right: -50),
              Padding(
                padding: const EdgeInsets.all(_sectionPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCardHeader(item, cardColor),
                    const Spacer(),
                    Text(
                      item['subtitle'] as String,
                      style: TextStyle(
                        color: ClarxCoreApp.textColor.withOpacity(0.7),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          item['time'] as String,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.people, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          '${item['parts']}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cardColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: _buttonPaddingH,
                            vertical: _buttonPaddingV,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_borderRadius),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // Kart içi işlem
                        },
                        child: const Text(
                          'Katıl',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  Widget _buildAccent(Color color, double size,
      {double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget _buildCardHeader(Map<String, dynamic> item, Color badgeColor) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: badgeColor.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item['icon'] as IconData,
            color: Colors.white,
            size: _iconLarge,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            item['title'] as String,
            style: const TextStyle(
              color: ClarxCoreApp.textColor,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(_borderRadius),
            boxShadow: [
              BoxShadow(
                color: badgeColor.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            'AKTİF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
