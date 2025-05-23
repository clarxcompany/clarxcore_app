// lib/widgets/active_page/history_card/history_card.dart

import 'package:flutter/material.dart';
import '../../../../main.dart';

class HistoryCard extends StatelessWidget {
  final DateTime    date;
  final bool        isTask;
  final bool        isSport;
  final bool        isSelected;
  final VoidCallback onTap;

  const HistoryCard({
    Key? key,
    required this.date,
    required this.isTask,
    required this.isSport,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  // Ölçüler:
  static const double _cellSize   = 36.0;
  static const double _cellMargin = 2.0;
  static const double _iconSize   = 18.0;
  static const double _fontSize   = 14.0;

  @override
  Widget build(BuildContext context) {
    final dayStr = date.day.toString();

    // Default: transparan + gri sayı
    Color bgColor  = Colors.transparent;
    Widget content = Text(
      dayStr,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize:  _fontSize,
        fontWeight: FontWeight.w600,
        color:      Colors.grey,
      ),
    );

    if (isSelected) {
      // Seçili gün: koyu daire + beyaz sayı
      bgColor = ClarxCoreApp.primaryColor;
      content = Text(
        dayStr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize:  _fontSize,
          fontWeight: FontWeight.w600,
          color:      Colors.white,
        ),
      );
    }
    else if (isTask) {
      // Günlük görev: koyu daire + check ikonu
      bgColor = ClarxCoreApp.primaryColor;
      content = Icon(
        Icons.check,
        size: _iconSize,
        color: Colors.white,
      );
    }
    else if (isSport) {
      // Spor: mint daire + fitness_center ikonu
      bgColor = ClarxCoreApp.secondaryColor.withOpacity(0.3);
      content = Icon(
        Icons.fitness_center,
        size: _iconSize,
        color: ClarxCoreApp.primaryColor,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  _cellSize,
        height: _cellSize,
        margin: const EdgeInsets.all(_cellMargin),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(_cellSize / 2),
        ),
        alignment: Alignment.center,
        child: content,
      ),
    );
  }
}
