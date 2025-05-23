// lib/screens/profile_page.dart

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';            // <<< share_plus importu
import '../main.dart';
import '../widgets/profile/profile_info_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // Sabit demo verileri
  final String fullName = 'John Doe';
  final String username = 'johndoe123';
  final int sessions = 3;
  final int sessionDuration = 45;
  final List<String> slots = const ['Sabah', 'Akşam'];

  // Profil linkini üretme (örnek)
  String get profileUrl => 'https://clarxcore.app/user/$username';

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final primary = ClarxCoreApp.primaryColor;

    // Header’daki metric kart verileri
    final metrics = [
      {
        'label': 'Kilo',
        'value': '$sessions seans',
        'gradient': [primary, primary.withOpacity(0.7)]
      },
      {
        'label': 'Seans Süresi',
        'value': '$sessionDuration dk',
        'gradient': [primary.withOpacity(0.8), primary.withOpacity(0.5)]
      },
      {
        'label': 'Slot',
        'value': slots.join(', '),
        'gradient': [primary.withOpacity(0.6), primary.withOpacity(0.3)]
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // ─── HEADER ───────────────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            child: Container(
              width: double.infinity,
              height: 340,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/header_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(16, topPad + 16, 16, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar, İsim, Kullanıcı Adı, İkonlar
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/icons/person.png',
                            width: 80, height: 80, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80, height: 80,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.person, size: 48, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fullName,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                              Text('@$username',
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 16)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications, color: Colors.white),
                          onPressed: () {}, // Bildirimler sayfasına yönlendirme
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.white),
                          onPressed: () {}, // Ayarlar sayfasına yönlendirme
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Metric kartları
                    SizedBox(
                      height: 110,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: metrics.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, i) {
                          final m = metrics[i];
                          return Container(
                            width: 120,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: m['gradient'] as List<Color>),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(m['label'] as String,
                                    style: const TextStyle(color: Colors.white70)),
                                const Spacer(),
                                Text(m['value'] as String,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Paylaş & Düzenle butonları
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white70),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          icon: const Icon(Icons.share, color: Colors.white),
                          label: const Text('Paylaş', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            // Android/iOS paylaşım diyalogunu aç
                            Share.share(
                              'Benim ClarxCore Profilimi incele: $profileUrl',
                              subject: 'ClarxCore Profilim',
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white70),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: const Text('Düzenle', style: TextStyle(color: Colors.white)),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── DİĞER LİSTE ──────────────────────────────
          Expanded(
            child: ProfileInfoPage(),
          ),
        ],
      ),
    );
  }
}
