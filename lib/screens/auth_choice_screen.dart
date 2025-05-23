// lib/screens/auth_choice_screen.dart

import 'package:flutter/material.dart';
import 'login_page.dart';

class AuthChoiceScreen extends StatefulWidget {
  const AuthChoiceScreen({Key? key}) : super(key: key);

  @override
  _AuthChoiceScreenState createState() => _AuthChoiceScreenState();
}

class _AuthChoiceScreenState extends State<AuthChoiceScreen> {
  int _currentPage = 0;

  static const _pages = <_OnboardingPage>[
    _OnboardingPage(
      imageAsset: 'assets/auth_choice_page/onboard1.png',
      title: 'GÜNLÜK\nGÖREVLER',
      description:
      'Her gün yapman gereken kişisel görevleri planla, hatırlat ve tamamla.',
      bgColor: Color(0xFF0F252E),
    ),
    _OnboardingPage(
      imageAsset: 'assets/auth_choice_page/onboard2.png',
      title: 'SPOR\nAKTİVİTELERİ',
      description:
      'Koşu, bisiklet, yoga ve daha fazlasını seç, ilerlemeni kaydet ve motive ol.',
      bgColor: Color(0xFF2C6F67),
    ),
    _OnboardingPage(
      imageAsset: 'assets/auth_choice_page/onboard3.png',
      title: 'TOPLULUK\nDESTEĞİ',
      description:
      'Arkadaşlarınla yarış, başarılarını paylaş ve birbirinize ilham verin.',
      bgColor: Color(0xFF000000),
    ),
    _OnboardingPage(
      imageAsset: 'assets/auth_choice_page/onboard4.png',
      title: 'AI DESTEKLİ\nÖNERİLER',
      description:
      'Yapay zeka, sana özel görev ve antrenman önerileri sunsun.',
      bgColor: Color(0xFF0F252E),
    ),
    _OnboardingPage(
      imageAsset: 'assets/auth_choice_page/onboard5.png',
      title: 'HEMEN\nBAŞLA!',
      description:
      'clarxcore ile hemen görevlerine ve sporlara başla, gerçek ilerlemeyi hisset!',
      bgColor: Color(0xFF53B5AB),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      setState(() => _currentPage++);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];
    // Cihaz çentiği / navbar boşluğu
    final topInset = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: page.bgColor,
      body: SafeArea(
        top: false, // yükseklik %60 + topInset ile kontrol ediliyor
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Tam ekranın %60'ı kadar görsel ---
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: SizedBox(
                  height:
                  (MediaQuery.of(context).size.height * 0.6) + topInset,
                  width: double.infinity,
                  child: Image.asset(
                    page.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // --- Metin & buton bölümü ---
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  24,
                  16,
                  24 + bottomInset, // alt inset kadar ekstra boşluk
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Başlık
                    Text(
                      page.title,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Açıklama
                    Text(
                      page.description,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Nokta göstergeleri
                    Row(
                      children: List.generate(_pages.length, (i) {
                        final isActive = i == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 8),
                          width: isActive ? 36 : 16,
                          height: isActive ? 14 : 10,
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(isActive ? 0.9 : 0.3),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 32),

                    // Sağda, taştışmayan “Devam →” / “Hadi Başlayalım →”
                    Align(
                      alignment: Alignment.centerRight,
                      child: IntrinsicWidth(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: ElevatedButton.icon(
                            onPressed: _nextPage,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: page.bgColor,
                            ),
                            label: Text(
                              _currentPage < _pages.length - 1
                                  ? 'Devam'
                                  : 'Hadi Başlayalım',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: page.bgColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 2,
                              minimumSize: const Size(0, 52),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String imageAsset;
  final String title;
  final String description;
  final Color bgColor;
  const _OnboardingPage({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.bgColor,
  });
}
