// lib/screens/legal/terms_of_use_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:clarxcore_app/main.dart';

class TermsOfUsePage extends StatefulWidget {
  const TermsOfUsePage({Key? key}) : super(key: key);

  @override
  _TermsOfUsePageState createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  String _mdData = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
  }

  Future<void> _loadMarkdown() async {
    final data = await rootBundle.loadString('assets/legal/terms_of_use.md');
    setState(() => _mdData = data);
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Terms of Use',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0F252E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _mdData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: MarkdownBody(
              data: _mdData,
              styleSheet: styleSheet,
            ),
          ),
        ],
      ),
    );
  }
}
