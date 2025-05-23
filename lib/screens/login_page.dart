// lib/screens/login_page.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart'; // theme renklerimiz burada
import 'legal/terms_of_use_page.dart';
import 'legal/privacy_policy_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool _loading    = false;
  bool _obscure    = true;

  @override
  void dispose() {
    _passCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş Hatası: ${e.message}')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary   = ClarxCoreApp.primaryColor;
    final secondary = ClarxCoreApp.secondaryColor;
    final bg        = ClarxCoreApp.backgroundColor;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- HEADER IMAGE ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/login_page/login_header.png',
                    width: double.infinity,
                    height: 380,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // --- FORM BAŞLANGICI ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pushNamed('/register'),
                          child: Text(
                            'Register',
                            style: TextStyle(color: secondary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email
                            TextFormField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email address',
                                prefixIcon: Icon(Icons.email, color: primary),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (v) => v != null && v.contains('@')
                                  ? null
                                  : 'Geçerli e-posta girin',
                            ),
                            const SizedBox(height: 16),

                            // Password
                            TextFormField(
                              controller: _passCtrl,
                              obscureText: _obscure,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock, color: primary),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure ? Icons.visibility_off : Icons.visibility,
                                    color: primary.withOpacity(0.7),
                                  ),
                                  onPressed: () => setState(() => _obscure = !_obscure),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (v) =>
                              v != null && v.length >= 6 ? null : 'En az 6 karakter girin',
                            ),
                            const SizedBox(height: 24),

                            // Continue butonu
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton.icon(
                                icon: _loading
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2),
                                )
                                    : const SizedBox.shrink(),
                                label: Text(
                                  'Continue',
                                  style: TextStyle(fontSize: 18, color: primary),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  elevation: 2,
                                ),
                                onPressed: _loading ? null : _login,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // or sign up with
                            Row(
                              children: [
                                const Expanded(child: Divider(color: Colors.black26)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'or sign up with',
                                    style: TextStyle(color: primary.withOpacity(0.7)),
                                  ),
                                ),
                                const Expanded(child: Divider(color: Colors.black26)),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Sosyal giriş butonları
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  onPressed: () { /* Google login */ },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.black26),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                    padding: const EdgeInsets.all(12),
                                    minimumSize: const Size(48, 48),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.google,
                                    size: 28,
                                    color: Color(0xFFDB4437),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () { /* Facebook login */ },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.black26),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                    padding: const EdgeInsets.all(12),
                                    minimumSize: const Size(48, 48),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    size: 28,
                                    color: Color(0xFF1877F2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Alt metin: Terms & Privacy
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text.rich(
                  TextSpan(
                    text: 'By clicking Continue you agree to ',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                    children: [
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(color: secondary, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const TermsOfUsePage())
                            );
                          },
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(color: secondary, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const PrivacyPolicyPage())
                            );
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
