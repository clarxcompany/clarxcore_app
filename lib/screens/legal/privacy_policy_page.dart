// lib/screens/legal/privacy_policy_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:clarxcore_app/main.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerColor = const Color(0xFF0F252E);
    final bgColor     = Colors.grey.shade100;

    final styleSheet = MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      h1: TextStyle(
        color: ClarxCoreApp.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      h2: TextStyle(
        color: ClarxCoreApp.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      p: TextStyle(
        color: ClarxCoreApp.textColor,
        fontSize: 16,
        height: 1.5,
      ),
      listBullet: TextStyle(
        color: ClarxCoreApp.textColor,
        fontSize: 16,
      ),
      blockSpacing: 16,
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: headerColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<String>(
        // Burada dosya adını düzeltelim:
        future: rootBundle.loadString('assets/legal/privacy_policy.md'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
            debugPrint('Error loading privacy_policy.md: ${snapshot.error}');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Yüklenirken hata oluştu:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: MarkdownBody(
                  data: snapshot.data!,
                  styleSheet: styleSheet,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
