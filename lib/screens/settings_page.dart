// lib/screens/settings_page.dart

import 'package:flutter/material.dart';
import '../main.dart'; // themeModeNotifier için

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Bildirim ayarları
  bool _dailyTasks = true;
  bool _sportsReminders = true;
  bool _aiSuggestions = true;
  bool _weeklyReports = true;

  // Entegrasyonlar
  bool _syncApple = true;
  bool _syncGoogle = false;
  bool _syncObsidian = true;

  // Dil
  String _language = 'Türkçe';
  final List<String> _languages = ['Türkçe', 'English', 'Español'];

  // Güvenlik
  bool _biometric = true;
  bool _locationPerm = true;
  bool _micPerm = false;

  @override
  Widget build(BuildContext context) {
    final primary = ClarxCoreApp.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ayarlar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 1. Bildirimler
          _sectionHeader('Bildirimler'),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Günlük Görev Hatırlatmaları'),
            value: _dailyTasks,
            onChanged: (v) => setState(() => _dailyTasks = v),
          ),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Spor Hatırlatmaları'),
            value: _sportsReminders,
            onChanged: (v) => setState(() => _sportsReminders = v),
          ),
          SwitchListTile(
            activeColor: primary,
            title: const Text('AI Plan Önerileri'),
            value: _aiSuggestions,
            onChanged: (v) => setState(() => _aiSuggestions = v),
          ),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Haftalık Performans Raporları'),
            value: _weeklyReports,
            onChanged: (v) => setState(() => _weeklyReports = v),
          ),

          const Divider(height: 32),

          // 2. Hesap
          _sectionHeader('Hesap'),
          ListTile(
            leading: Icon(Icons.person_outline, color: primary),
            title: const Text('Profil Düzenle'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {/* Profil düzenleme */},
          ),
          ListTile(
            leading: Icon(Icons.lock_outline, color: primary),
            title: const Text('Şifre Değiştir'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {/* Şifre değiştir */},
          ),
          ListTile(
            leading: Icon(Icons.subscriptions_outlined, color: primary),
            title: const Text('Aboneliklerim'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {/* Abonelik yönetimi */},
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text(
              'Hesabı Sil',
              style: TextStyle(color: Colors.red),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.red),
            onTap: () {/* Hesap silme */},
          ),

          const Divider(height: 32),

          // 3. Entegrasyonlar
          _sectionHeader('Entegrasyonlar'),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Apple Health Senkronizasyonu'),
            value: _syncApple,
            onChanged: (v) => setState(() => _syncApple = v),
          ),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Google Fit Senkronizasyonu'),
            value: _syncGoogle,
            onChanged: (v) => setState(() => _syncGoogle = v),
          ),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Obsidian Senkronizasyonu'),
            value: _syncObsidian,
            onChanged: (v) => setState(() => _syncObsidian = v),
          ),

          const Divider(height: 32),

          // 4. Görünüm: Koyu/Açık mod
          _sectionHeader('Görünüm'),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              return SwitchListTile(
                activeColor: primary,
                title: const Text('Koyu Mod'),
                value: (mode == ThemeMode.dark),
                onChanged: (isDark) {
                  themeModeNotifier.value =
                  isDark ? ThemeMode.dark : ThemeMode.light;
                },
              );
            },
          ),

          const Divider(height: 32),

          // 5. Dil
          _sectionHeader('Dil'),
          ListTile(
            leading: Icon(Icons.language, color: primary),
            title: const Text('Uygulama Dili'),
            trailing: DropdownButton<String>(
              value: _language,
              underline: const SizedBox(),
              items: _languages
                  .map((lang) => DropdownMenuItem(
                value: lang,
                child: Text(lang),
              ))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _language = val);
              },
            ),
          ),

          const Divider(height: 32),

          // 6. Güvenlik
          _sectionHeader('Güvenlik'),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Biometrik Kimlik Doğrulama'),
            value: _biometric,
            onChanged: (v) => setState(() => _biometric = v),
          ),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Konum İzni'),
            value: _locationPerm,
            onChanged: (v) => setState(() => _locationPerm = v),
          ),
          SwitchListTile(
            activeColor: primary,
            title: const Text('Mikrofon İzni'),
            value: _micPerm,
            onChanged: (v) => setState(() => _micPerm = v),
          ),

          const Divider(height: 32),

          // 7. Veri & Önbellek
          _sectionHeader('Veri & Önbellek'),
          ListTile(
            leading: Icon(Icons.upload_file, color: primary),
            title: const Text('Veri Dışa Aktar'),
            onTap: () {/* Dışa aktarma */},
          ),
          ListTile(
            leading: Icon(Icons.download_rounded, color: primary),
            title: const Text('Veri İçe Aktar'),
            onTap: () {/* İçe aktarma */},
          ),
          ListTile(
            leading: Icon(Icons.delete_sweep, color: primary),
            title: const Text('Önbelleği Temizle'),
            onTap: () {/* Önbellek temizleme */},
          ),

          const Divider(height: 32),

          // 8. Gizlilik & Hakkında
          _sectionHeader('Gizlilik & Hakkında'),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined, color: primary),
            title: const Text('Gizlilik Politikası'),
            onTap: () {/* Politika */},
          ),
          ListTile(
            leading: Icon(Icons.description_outlined, color: primary),
            title: const Text('Kullanım Şartları'),
            onTap: () {/* Şartlar */},
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: primary),
            title: const Text('Uygulama Hakkında'),
            onTap: () {/* Hakkında */},
          ),
          ListTile(
            leading: Icon(Icons.tag, color: primary),
            title: const Text('Sürüm'),
            trailing: Text(
              '1.0.0',
              style: TextStyle(color: ClarxCoreApp.textColor),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: ClarxCoreApp.textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
