// lib/widgets/date_selector.dart

import 'package:flutter/material.dart';
import '../main.dart';

/// “Tarih Seçici” widget’ı:
/// - Hesap açılış gününden başlayarak bugüne kadar ve
///   en fazla 2 gün sonrasına kadar listeler.
/// - Seçili gün yalnızca yazı kalınlaştırılarak ve
///   altındaki gösterge çizgisiyle (indicator) vurgulanır.
/// - Açılışta ve seçimde seçili gün tam ortada görünür.
/// - Sağda 2 günden sonra ekstra boşluk bırakır (azaltıldı).
/// - Sola kaydırma serbest, sağ aşımda otomatik merkezleme yapar.
class DateSelector extends StatefulWidget {
  final DateTime accountOpenedAt;
  final Set<DateTime> completedDates;

  const DateSelector({
    Key? key,
    required this.accountOpenedAt,
    required this.completedDates,
  }) : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  static const _itemWidth = 60.0;
  static const _spacing = 16.0;
  static const _indicatorHeight = 4.0;
  // Eski: 32.0; Yeni: 16.0 ile sağ boşluğu azalttık
  static const _extraRightPadding = 16.0;

  static const List<String> _weekdayLabels = [
    'Paz', 'Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt'
  ];

  final ScrollController _controller = ScrollController();
  late final List<DateTime> _dates;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _buildDates();
    WidgetsBinding.instance.addPostFrameCallback((_) => _centerSelected());
  }

  void _buildDates() {
    final today = DateTime.now();
    final start = DateTime(
      widget.accountOpenedAt.year,
      widget.accountOpenedAt.month,
      widget.accountOpenedAt.day,
    );
    final end = DateTime(today.year, today.month, today.day)
        .add(const Duration(days: 2));

    _dates = [];
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      _dates.add(d);
    }

    final idx = _dates.indexWhere((d) =>
    d.year == today.year &&
        d.month == today.month &&
        d.day == today.day);
    _selectedIndex = idx >= 0 ? idx : 0;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _centerSelected() {
    final fullItem = _itemWidth + _spacing;
    final target = _selectedIndex * fullItem;
    final maxScroll = _controller.position.maxScrollExtent;
    final offset = target.clamp(0.0, maxScroll);
    _controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onTap(int i) {
    setState(() => _selectedIndex = i);
    WidgetsBinding.instance.addPostFrameCallback((_) => _centerSelected());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final leftPad = (screenWidth - _itemWidth) / 2;
    final rightPad = leftPad + _extraRightPadding;

    return SizedBox(
      height: _itemWidth + _indicatorHeight + 32,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (n) {
          final pos = _controller.position.pixels;
          final fullItem = _itemWidth + _spacing;
          final threshold = (_selectedIndex * fullItem) + (_extraRightPadding / 2);
          if (pos > threshold) _centerSelected();
          return false;
        },
        child: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(left: leftPad, right: rightPad),
          itemCount: _dates.length,
          itemBuilder: (_, i) => _buildDateItem(i),
        ),
      ),
    );
  }

  Widget _buildDateItem(int i) {
    final d = _dates[i];
    final isSelected = i == _selectedIndex;
    final isToday = _isSameDay(d, DateTime.now());
    final weekday = _weekdayLabels[d.weekday % 7];
    final dayText = d.day.toString().padLeft(2, '0');
    final done = widget.completedDates.any((cd) => _isSameDay(cd, d));

    final color = isSelected
        ? ClarxCoreApp.primaryColor
        : ClarxCoreApp.textColor;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

    return GestureDetector(
      onTap: () => _onTap(i),
      child: Container(
        width: _itemWidth,
        margin: EdgeInsets.only(
          right: i == _dates.length - 1 ? 0 : _spacing,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              style: TextStyle(
                fontSize: isSelected ? 16 : 14,
                fontWeight: fontWeight,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dayText,
              style: TextStyle(
                fontSize: isSelected ? 20 : 16,
                fontWeight: fontWeight,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            if (done)
              Container(
                width: _indicatorHeight,
                height: _indicatorHeight,
                decoration: BoxDecoration(
                  color: ClarxCoreApp.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isToday ? _itemWidth * 0.6 : 0,
              height: _indicatorHeight,
              decoration: BoxDecoration(
                color: ClarxCoreApp.primaryColor,
                borderRadius: BorderRadius.circular(_indicatorHeight / 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
