// lib/widgets/app_navigation.dart

import 'package:flutter/material.dart';
import '../main.dart';

class AppNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  static const _icons = [
    Icons.home_outlined,
    Icons.star_border,
    Icons.group_outlined,
    Icons.person_outline,
  ];
  static const _iconsFilled = [
    Icons.home,
    Icons.star,
    Icons.group,
    Icons.person,
  ];
  static const _labels = [
    'Ana Sayfa',
    'Favoriler',
    'Topluluk',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    const navBarHeight = 56.0;

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        height: navBarHeight + bottomPad,
        padding: EdgeInsets.only(bottom: bottomPad),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_icons.length, (i) => _buildNavIcon(i)),
        ),
      ),
    );
  }

  Widget _buildNavIcon(int idx) {
    final isSelected = idx == selectedIndex;
    return IconButton(
      onPressed: () => onTap(idx),
      icon: Icon(
        isSelected ? _iconsFilled[idx] : _icons[idx],
        size: isSelected ? 34 : 28,
        color: isSelected
            ? ClarxCoreApp.primaryColor
            : ClarxCoreApp.textColor,
      ),
      splashRadius: 24,
      tooltip: _labels[idx],
    );
  }
}
