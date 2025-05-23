// lib/widgets/home_header.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/settings_page.dart';
import '../screens/notifications_page.dart';

class HomeHeader extends StatelessWidget {
  /// Kullanıcı adını alıyoruz
  final String userName;

  const HomeHeader({Key? key, required this.userName}) : super(key: key);

  // Esneme ve Koşu metinleri
  static const String todayTask = 'Esneme';
  static const String todaySport = 'Koşu';

  // 24 saatlik görev süresi (demo)
  Duration get _dailyTaskDuration => const Duration(hours: 24);
  DateTime get _dailyTaskStart =>
      DateTime.now().subtract(const Duration(hours: 12));

  String _formatRemaining() {
    final end = _dailyTaskStart.add(_dailyTaskDuration);
    final rem = end.difference(DateTime.now());
    final h = rem.inHours.toString().padLeft(2, '0');
    final m = (rem.inMinutes % 60).toString().padLeft(2, '0');
    final s = (rem.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top + 16;
    const sidePad = 16.0;
    const headerHeight = 360.0;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      child: Container(
        height: headerHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/header_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.black.withOpacity(0.4),
              ],
            ),
          ),
          padding: EdgeInsets.fromLTRB(sidePad, topPad, sidePad, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopRow(context),
              const SizedBox(height: 16),
              Text(
                'Hello, $userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),

              // Tek kart arkaplan: Esneme, Sayaç, Koşu
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white24),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Esneme bölümü
                        _headerAction(
                          icon: Icons.self_improvement,
                          label: todayTask,
                          sublabel: 'Günlük Görev',
                          onTap: () =>
                              Navigator.pushNamed(context, '/dailyTasks'),
                        ),
                        const SizedBox(width: 12),
                        // Sayaç bölümü (FittedBox ile taşmayı önlüyoruz)
                        _headerTimer(),
                        const SizedBox(width: 12),
                        // Koşu bölümü
                        _headerAction(
                          icon: Icons.fitness_center,
                          label: todaySport,
                          sublabel: 'Spor Aktivite',
                          onTap: () => Navigator.pushNamed(context, '/sports'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      children: [
        const Text(
          'clarxcore',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.notifications),
          color: Colors.white70,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationsPage()),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          color: Colors.white70,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          ),
        ),
      ],
    );
  }

  Widget _headerAction({
    required IconData icon,
    required String label,
    required String sublabel,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white30,
              child: Icon(icon, size: 32, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sublabel,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerTimer() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Text(
                _formatRemaining(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kalan Süre',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
