// lib/widgets/active_page/active_sport/active_sport_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../main.dart';

class ActiveSportCard extends StatelessWidget {
  /// Kartta gösterilecek tarih
  final DateTime date;
  /// Toplam aktivite süresi
  final Duration totalDuration;
  /// Aktivite kalitesi skoru (0–10)
  final double activityScore;
  /// Ortalama kalp atış hızı
  final int avgBpm;

  const ActiveSportCard({
    Key? key,
    required this.date,
    this.totalDuration = const Duration(hours: 1, minutes: 45),
    this.activityScore = 8.5,
    this.avgBpm = 130,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.MMMM().format(date) + ' ${date.day}';
    final hours = totalDuration.inHours;
    final minutes = totalDuration.inMinutes % 60;
    final durationText = '${hours}h ${minutes}m';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ——— Sekmeler: Overview, Heart Rate, Calories ———
          Row(
            children: [
              const Text('Overview',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(width: 24),
              Text('Heart Rate',
                  style: TextStyle(fontSize: 14, color: Colors.black38)),
              const SizedBox(width: 24),
              Text('Calories',
                  style: TextStyle(fontSize: 14, color: Colors.black38)),
            ],
          ),

          const SizedBox(height: 16),

          // ——— Başlık + Skor + Detay butonu ———
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Workout\n',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.0,
                        ),
                      ),
                      TextSpan(
                        text: 'Summary',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                activityScore.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: ClarxCoreApp.secondaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: ClarxCoreApp.secondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.open_in_new,
                    size: 18, color: ClarxCoreApp.secondaryColor),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ——— İkon satırı ———
          Row(
            children: [
              _iconButton(Icons.share),
              const SizedBox(width: 12),
              _iconButton(Icons.bar_chart),
              const Spacer(),
              _iconButton(Icons.timer),
            ],
          ),

          const SizedBox(height: 24),

          // ——— TOTAL TIME bölümü ———
          const Text(
            'TOTAL TIME',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                durationText,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'on $formattedDate',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.favorite,
                        size: 14, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Text(
                      '$avgBpm BPM',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ——— Aşama grafiği ———
          Row(
            children: [
              _stageBar(0.1, ClarxCoreApp.secondaryColor.withOpacity(0.3)),
              _stageBar(0.3, ClarxCoreApp.secondaryColor.withOpacity(0.5)),
              _stageBar(0.4, ClarxCoreApp.secondaryColor),
              _stageBar(0.2, ClarxCoreApp.secondaryColor.withOpacity(0.8)),
            ],
          ),

          const SizedBox(height: 8),

          // ——— Aşama etiketleri ———
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _StageLabel(label: 'Warm-up', duration: '10m'),
              _StageLabel(label: 'Cardio', duration: '30m'),
              _StageLabel(label: 'Strength', duration: '40m'),
              _StageLabel(label: 'Cool-down', duration: '25m'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) => Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: ClarxCoreApp.secondaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, size: 24, color: ClarxCoreApp.primaryColor),
  );

  Widget _stageBar(double flex, Color color) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Container(
        height: 12,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class _StageLabel extends StatelessWidget {
  final String label, duration;
  const _StageLabel({required this.label, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 2),
        Text(duration,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
