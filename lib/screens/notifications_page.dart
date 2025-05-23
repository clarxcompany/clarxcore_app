// lib/screens/notifications_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.task_alt,
      'title': 'Günlük Görev Hatırlatması',
      'message': 'Sabah esneme görevini tamamlamayı unutma!',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
      'read': false,
    },
    {
      'icon': Icons.fitness_center,
      'title': 'Spor Hatırlatması',
      'message': 'Öğle vakti yoga seansı başladı.',
      'time': DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
      'read': true,
    },
    {
      'icon': Icons.smart_toy,
      'title': 'AI Plan Önerisi',
      'message': 'Yarın için 30 dakikalık koşu planı önerildi.',
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'read': false,
    },
    {
      'icon': Icons.bar_chart,
      'title': 'Haftalık Rapor Hazır',
      'message': 'Geçen haftanın performans raporunu görüntüleyebilirsin.',
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primary = ClarxCoreApp.primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bildirimler',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: () {
              setState(() {
                for (var n in _notifications) {
                  n['read'] = true;
                }
              });
            },
            tooltip: 'Tümünü Okundu Olarak İşaretle',
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final n = _notifications[index];
          final time = n['time'] as DateTime;
          final isRead = n['read'] as bool;
          return ListTile(
            tileColor: isRead ? Colors.white : Colors.grey.shade100,
            leading: CircleAvatar(
              backgroundColor: primary.withOpacity(0.1),
              child: Icon(n['icon'] as IconData, color: primary),
            ),
            title: Text(
              n['title'] as String,
              style: TextStyle(
                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                color: ClarxCoreApp.textColor,
              ),
            ),
            subtitle: Text(
              n['message'] as String,
              style: TextStyle(color: ClarxCoreApp.textColor.withOpacity(0.7)),
            ),
            trailing: Text(
              DateFormat('HH:mm').format(time),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            onTap: () {
              setState(() => n['read'] = true);
            },
          );
        },
      ),
    );
  }
}
