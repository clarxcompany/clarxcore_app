// lib/widgets/profile/profile_info_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';

/// Detaylı kullanıcı bilgilerini kategori başlıkları altında
/// OKX tarzı bir listede sunar. Yazılar daha koyu renklerle güncellendi.
class ProfileInfoPage extends StatelessWidget {
  ProfileInfoPage({Key? key}) : super(key: key);

  // Simüle edilmiş kullanıcı verileri
  final Map<String, dynamic> _user = {
    // 1. Temel Hesap Bilgileri
    'fullName': 'John Doe',
    'username': 'johndoe123',
    'email': 'john@example.com',
    'password': '••••••••',
    'passwordConfirm': '••••••••',
    'phone': '+90 555 123 4567',
    'birthDate': DateTime(1990, 1, 1),
    'gender': 'Erkek',
    // 2. Profil & İletişim Tercihleri
    'timeZone': 'Europe/Istanbul',
    'language': 'Türkçe',
    'notifDaily': true,
    'notifAI': true,
    'notifCommunity': false,
    'notifWeeklyReport': true,
    // 3A. Spor Aktiviteleri
    'favoriteSports': ['Koşu', 'Yoga'],
    'weeklySessions': 3,
    'avgSessionDuration': 45,
    'preferredSlots': ['Sabah', 'Akşam'],
    'sportEnv': 'Açık Hava',
    'equipment': ['Dumbbell', 'Mat'],
    'motivation': ['Rozetler', 'Arkadaş Yarışmaları'],
    // 3B. Günlük Görevler & Misyonlar
    'taskCategories': ['Meditasyon', 'Okuma'],
    'catPriority': {'Meditasyon': 4, 'Okuma': 3},
    'dailyTarget': 5,
    'frequency': 'Günlük',
    'difficulty': 'Orta',
    'quickStarts': ['Meditasyon Şablonu'],
    // 4. Gelişmiş Spor & Görev Verileri
    'stepGoal': 10000,
    'moveGoal': 300,
    'shortGoals': ['4 Hafta Adım Hedefi'],
    'longGoals': ['6 Ay Kilo Kaybı'],
    'experience': 'Orta',
    'healthCond': 'Yok',
    'programFlex': 'Esnek',
    'groupSolo': 'Solo',
    'socialShare': true,
    // 5. Cihaz & Entegrasyon Tercihleri
    'syncApple': true,
    'syncGoogle': false,
    'wearable': true,
    'calendars': ['Google Takvim'],
    'pushEmail': true,
    // 6. Konum & Hava Durumu Bilgileri
    'city': 'İstanbul',
    'zip': '34000',
    'autoWeather': true,
    // 7. Günlük Rutin & Program Bilgileri
    'wakeUp': TimeOfDay(hour: 7, minute: 0),
    'sleep': TimeOfDay(hour: 23, minute: 0),
    'workStart': TimeOfDay(hour: 9, minute: 0),
    'workEnd': TimeOfDay(hour: 18, minute: 0),
    'breaks': 'Her 2 saatte 10 dk',
    'mealRemind': true,
    // 8. Sosyal & Topluluk Ayarları
    'friendPerm': true,
    'teamTasks': true,
    'leaderboard': 'Herkese Açık',
    'groups': ['Koşu Grubu', 'Yoga Grubu'],
    // 9. Abonelik & Ödeme Bilgileri
    'plan': 'Premium Yıllık',
    'payment': 'Kredi Kartı',
    'billing': 'İstanbul, TR',
    // 10. Güvenlik & İzinler
    'biometric': 'Face ID',
    'locationPerm': true,
    'micPerm': false,
    'apiAccess': false,
    // 11. Ek Onaylar & Politikalar
    'terms': true,
    'healthDisclaimer': true,
    'marketingEmails': false,
    'dataSharing': false,
  };

  String _fmtDate(DateTime d) => DateFormat('dd/MM/yyyy').format(d);
  String _fmtTime(TimeOfDay t, BuildContext c) => t.format(c);

  Widget _header(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: ClarxCoreApp.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _tile(String label, String value) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        label,
        style: TextStyle(
          color: ClarxCoreApp.textColor, // başlık koyu renk
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          color: ClarxCoreApp.textColor, // değer koyu renk
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24, top: 0),
      children: [
        // 1. Temel Hesap Bilgileri
        _header('🆔 Temel Hesap Bilgileri'),
        _tile('Ad Soyad', _user['fullName']),
        _tile('Kullanıcı Adı', '@${_user['username']}'),
        _tile('E-posta Adresi', _user['email']),
        _tile('Şifre', _user['password']),
        _tile('Şifre Onayı', _user['passwordConfirm']),
        _tile('Telefon Numarası', _user['phone']),
        _tile('Doğum Tarihi', _fmtDate(_user['birthDate'])),
        _tile('Cinsiyet', _user['gender']),
        const Divider(),

        // 2. Profil & İletişim Tercihleri
        _header('🔔 Profil & İletişim Tercihleri'),
        _tile('Zaman Dilimi', _user['timeZone']),
        _tile('Dil Tercihi', _user['language']),
        _tile('Günlük Görev Hatırlatmaları', _user['notifDaily'] ? 'Açık' : 'Kapalı'),
        _tile('AI Destekli Plan Önerileri', _user['notifAI'] ? 'Açık' : 'Kapalı'),
        _tile('Topluluk Davetleri', _user['notifCommunity'] ? 'Açık' : 'Kapalı'),
        _tile('Haftalık Performans Raporları', _user['notifWeeklyReport'] ? 'Açık' : 'Kapalı'),
        const Divider(),

        // 3A. Spor Aktiviteleri
        _header('🏅 Spor Aktiviteleri'),
        _tile('Favori Spor Türleri', (_user['favoriteSports'] as List).join(', ')),
        _tile('Haftalık Seans Sayısı', '${_user['weeklySessions']}'),
        _tile('Ortalama Seans Süresi', '${_user['avgSessionDuration']} dk'),
        _tile('Tercih Edilen Zaman Dilimleri', (_user['preferredSlots'] as List).join(', ')),
        _tile('Spor Ortamı', _user['sportEnv']),
        _tile('Kullanılan Ekipmanlar', (_user['equipment'] as List).join(', ')),
        _tile('Motivasyon Unsurları', (_user['motivation'] as List).join(', ')),
        const Divider(),

        // 3B. Görev & Misyon Tercihleri
        _header('📋 Görev & Misyon Tercihleri'),
        _tile('Görev Kategorileri', (_user['taskCategories'] as List).join(', ')),
        _tile(
            'Kategori Öncelik',
            (_user['catPriority'] as Map)
                .entries
                .map((e) => '${e.key}:${e.value}')
                .join(', ')),
        _tile('Günlük Görev Adedi Hedefi', '${_user['dailyTarget']}'),
        _tile('Tekrar Sıklığı', _user['frequency']),
        _tile('Zorluk Seviyesi Tercihi', _user['difficulty']),
        _tile('Hızlı Başlangıç Planları', (_user['quickStarts'] as List).join(', ')),
        const Divider(),

        // 4. Gelişmiş Spor & Görev Verileri
        _header('❤️ Gelişmiş Spor & Görev Verileri'),
        _tile('Günlük Adım Hedefi', '${_user['stepGoal']} adım'),
        _tile('Haftalık Hareket Süresi Hedefi', '${_user['moveGoal']} dk'),
        _tile('Kısa Vadeli Hedefler', (_user['shortGoals'] as List).join(', ')),
        _tile('Uzun Vadeli Hedefler', (_user['longGoals'] as List).join(', ')),
        _tile('Geçmiş Deneyim Seviyesi', _user['experience']),
        _tile('Sağlık Durumu & Engeller', _user['healthCond']),
        _tile('Mesleki Program & Esneklik', _user['programFlex']),
        _tile('Grup vs Solo Çalışma Tercihi', _user['groupSolo']),
        _tile('Sosyal Paylaşım İzni', _user['socialShare'] ? 'Açık' : 'Kapalı'),
        const Divider(),

        // 5. Cihaz & Entegrasyon Tercihleri
        _header('📱 Cihaz & Entegrasyon Tercihleri'),
        _tile('Apple Health Senkronizasyonu', _user['syncApple'] ? 'Evet' : 'Hayır'),
        _tile('Google Fit Senk.', _user['syncGoogle'] ? 'Evet' : 'Hayır'),
        _tile('Wearable Bağlantı İzni', _user['wearable'] ? 'Evet' : 'Hayır'),
        _tile('Takvim & Görev Yönetimi', (_user['calendars'] as List).join(', ')),
        _tile('Push & E-posta Bildirimleri', _user['pushEmail'] ? 'Açık' : 'Kapalı'),
        const Divider(),

        // 6. Konum & Hava Durumu Bilgileri
        _header('🌤️ Konum & Hava Durumu Bilgileri'),
        _tile('Şehir / Posta Kodu', '${_user['city']} / ${_user['zip']}'),
        _tile('Otomatik Hava Durumu', _user['autoWeather'] ? 'Evet' : 'Hayır'),
        const Divider(),

        // 7. Günlük Rutin & Program Bilgileri
        _header('⏰ Günlük Rutin & Program Bilgileri'),
        _tile('Standart Uyanış Saati', _fmtTime(_user['wakeUp'] as TimeOfDay, context)),
        _tile('Standart Yatış Saati', _fmtTime(_user['sleep'] as TimeOfDay, context)),
        _tile(
            'İş / Okul Saatleri',
            '${_fmtTime(_user['workStart'] as TimeOfDay, context)}–${_fmtTime(_user['workEnd'] as TimeOfDay, context)}'),
        _tile('Mola & Dinlenme Tercihleri', _user['breaks']),
        _tile('Öğün / Su Hatırlatmaları', _user['mealRemind'] ? 'Evet' : 'Hayır'),
        const Divider(),

        // 8. Sosyal & Topluluk Ayarları
        _header('🤝 Sosyal & Topluluk Ayarları'),
        _tile('Arkadaş Ekleme / Takip İzni', _user['friendPerm'] ? 'Evet' : 'Hayır'),
        _tile('Takım Görevlerine Katılma', _user['teamTasks'] ? 'Evet' : 'Hayır'),
        _tile('Lider Tablo Görünürlüğü', _user['leaderboard']),
        _tile('Topluluk Gruplarına Katılma', (_user['groups'] as List).join(', ')),
        const Divider(),

        // 9. Abonelik & Ödeme Bilgileri
        _header('💳 Abonelik & Ödeme Bilgileri'),
        _tile('Premium Plan Seçimi', _user['plan']),
        _tile('Ödeme Yöntemi', _user['payment']),
        _tile('Faturalama Adresi', _user['billing']),
        const Divider(),

        // 10. Güvenlik & İzinler
        _header('🔒 Güvenlik & İzinler'),
        _tile('Biyometrik Giriş', _user['biometric']),
        _tile('GPS & Konum İzni', _user['locationPerm'] ? 'Evet' : 'Hayır'),
        _tile('Mikrofon İzni', _user['micPerm'] ? 'Evet' : 'Hayır'),
        _tile('API Erişim Onayı', _user['apiAccess'] ? 'Evet' : 'Hayır'),
        const Divider(),

        // 11. Ek Onaylar & Politikalar
        _header('✔️ Ek Onaylar & Politikalar'),
        _tile('Kullanım Şartları & Gizlilik', _user['terms'] ? 'Onaylandı' : 'Beklemede'),
        _tile('Sağlık Sorumluluğu Reddi', _user['healthDisclaimer'] ? 'Onaylandı' : 'Beklemede'),
        _tile('Pazarlama / E-posta İzinleri', _user['marketingEmails'] ? 'Evet' : 'Hayır'),
        _tile('Veri Paylaşım & Analitik İzni', _user['dataSharing'] ? 'Evet' : 'Hayır'),
      ],
    );
  }
}
