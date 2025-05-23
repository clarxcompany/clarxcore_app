// lib/screens/active_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../widgets/active_page/active_header/active_header.dart';
import '../widgets/active_page/history_card/history_card.dart';
import '../widgets/active_page/active_sport/active_sport_card.dart';
import '../widgets/app_navigation.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({Key? key}) : super(key: key);

  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  final Set<DateTime> _taskDates = {
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  };
  final Set<DateTime> _sportDates = {
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 1)),
  };

  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

  void _changeMonth(int delta) {
    setState(() {
      _focusedMonth = DateTime(
        _focusedMonth.year,
        _focusedMonth.month + delta,
        1,
      );
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 0, bottom: 16),
            children: [
              const ActiveHeader(),
              const SizedBox(height: 16),

              // ——— TAKVİM KARTI ———
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: ClarxCoreApp.backgroundColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: SizedBox(
                    height: 260,
                    child: Column(
                      children: [
                        _buildNavBar(),
                        const SizedBox(height: 8),
                        _buildWeekDays(),
                        const SizedBox(height: 4),
                        Expanded(child: _buildDatesGrid()),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ——— SPOR KARTI ———
              ActiveSportCard(
                date: _selectedDate ?? DateTime.now(),
              ),
            ],
          ),

          // Sabit geri butonu
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white24,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppNavigation(
        selectedIndex: -1,
        onTap: (_) {},
      ),
    );
  }

  Widget _buildNavBar() {
    final monthName = DateFormat.MMMM().format(_focusedMonth);
    final year = _focusedMonth.year;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _navButton(Icons.arrow_back_ios, () => _changeMonth(-1)),
          const Spacer(),
          Text(
            '$monthName $year',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          _navButton(Icons.arrow_forward_ios, () => _changeMonth(1)),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
            .map((d) => Expanded(
          child: Center(
            child: Text(
              d,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
        ))
            .toList(),
      ),
    );
  }

  Widget _buildDatesGrid() {
    final firstWeekday =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday % 7;
    final daysInMonth =
    DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final totalCells = firstWeekday + daysInMonth;
    final rows = (totalCells / 7).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: List.generate(rows, (row) {
          return Expanded(
            child: Row(
              children: List.generate(7, (col) {
                final idx = row * 7 + col;
                final dayNum = idx - firstWeekday + 1;
                if (dayNum < 1 || dayNum > daysInMonth) {
                  return const Expanded(child: SizedBox());
                }
                final date = DateTime(
                  _focusedMonth.year,
                  _focusedMonth.month,
                  dayNum,
                );
                final isTask = _taskDates.any((d) =>
                d.year == date.year &&
                    d.month == date.month &&
                    d.day == date.day);
                final isSport = _sportDates.any((d) =>
                d.year == date.year &&
                    d.month == date.month &&
                    d.day == date.day);

                return Expanded(
                  child: HistoryCard(
                    date: date,
                    isTask: isTask,
                    isSport: isSport,
                    isSelected: _selectedDate == date,
                    onTap: () => setState(() => _selectedDate = date),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: ClarxCoreApp.primaryColor),
        onPressed: onTap,
      ),
    );
  }
}
