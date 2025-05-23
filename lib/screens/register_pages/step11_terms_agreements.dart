// lib/screens/register_pages/step11_terms_agreements.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firestore_service.dart';
import '../register_flow.dart';

class Step11TermsAgreements extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onBack;

  const Step11TermsAgreements({
    Key? key,
    required this.data,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step11TermsAgreementsState createState() => _Step11TermsAgreementsState();
}

class _Step11TermsAgreementsState extends State<Step11TermsAgreements> {
  late bool _termsAccepted;
  late bool _liabilityWaiver;
  late bool _marketingOptIn;
  late bool _analyticsOptIn;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _termsAccepted = widget.data.termsAccepted;
    _liabilityWaiver = widget.data.liabilityWaiverAccepted;
    _marketingOptIn = widget.data.marketingOptIn;
    _analyticsOptIn = widget.data.analyticsOptIn;
  }

  Future<void> _register() async {
    if (!_termsAccepted || !_liabilityWaiver) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm zorunlu onayları kabul edin.')),
      );
      return;
    }
    setState(() => _loading = true);

    try {
      // 1) Firebase Auth ile kullanıcı oluştur
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.data.email.trim(),
        password: widget.data.password,
      );
      final uid = cred.user!.uid;

      // 2) Firestore’a tam profil kaydı
      await FirestoreService().createUserProfile(uid, widget.data);

      // 3) Kayıt tamamlandı → Ana sayfaya yönlendir
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt hatası: ${e.message}')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✔️ Ek Onaylar & Politikalar',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),

          // Zorunlu onaylar
          CheckboxListTile(
            title: const Text('Kullanım Şartları & Gizlilik Politikası onayı'),
            value: _termsAccepted,
            onChanged: (v) => setState(() => _termsAccepted = v ?? false),
          ),
          CheckboxListTile(
            title: const Text('Sağlık Sorumluluğu Reddi onayı'),
            value: _liabilityWaiver,
            onChanged: (v) => setState(() => _liabilityWaiver = v ?? false),
          ),

          const SizedBox(height: 16),
          // Opsiyonel onaylar
          CheckboxListTile(
            title: const Text('Pazarlama / E-posta İzinleri'),
            value: _marketingOptIn,
            onChanged: (v) => setState(() => _marketingOptIn = v ?? false),
          ),
          CheckboxListTile(
            title: const Text('Veri Paylaşım & Analitik İzni'),
            value: _analyticsOptIn,
            onChanged: (v) => setState(() => _analyticsOptIn = v ?? false),
          ),

          const Spacer(),

          Row(
            children: [
              TextButton(
                onPressed: widget.onBack,
                child: const Text('Geri'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _loading ? null : _register,
                child: _loading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text('Kayıt Ol'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
