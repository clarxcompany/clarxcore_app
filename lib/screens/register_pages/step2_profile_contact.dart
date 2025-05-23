// lib/screens/register_pages/step2_profile_contact.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../register_flow.dart';
import '../../main.dart';
import 'continue_button.dart';

class Step2ProfileContact extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step2ProfileContact({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step2ProfileContactState createState() => _Step2ProfileContactState();
}

class _Step2ProfileContactState extends State<Step2ProfileContact> {
  final _picker = ImagePicker();
  String? _language;

  @override
  void initState() {
    super.initState();
    _language = widget.data.language?.isNotEmpty == true
        ? widget.data.language
        : 'English';
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => widget.data.profilePhoto = picked.path);
    }
  }

  void _next() {
    widget.data.language = _language!;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final primary   = ClarxCoreApp.primaryColor;
    final bg        = ClarxCoreApp.backgroundColor;
    final languages = ['Türkçe', 'English', 'Deutsch', 'Español', 'Русский'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bg,
      appBar: AppBar(
        automaticallyImplyLeading: false, // geri butonunu tamamen kaldırır
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          'Profil & Bildirimler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Image.asset(
          'assets/register/step2_header.png',
          fit: BoxFit.cover,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: kToolbarHeight + MediaQuery.of(context).padding.top + 16,
          left: 20,
          right: 20,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Fotoğrafı
            Text(
              'Profil Fotoğrafı',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                  image: widget.data.profilePhoto != null
                      ? DecorationImage(
                    image: FileImage(File(widget.data.profilePhoto!)),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: widget.data.profilePhoto == null
                    ? Icon(Icons.camera_alt, size: 32, color: primary)
                    : null,
              ),
            ),
            const SizedBox(height: 24),

            // Dil Tercihi
            DropdownButtonFormField<String>(
              value: _language,
              decoration: InputDecoration(
                labelText: 'Dil Tercihi',
                prefixIcon: Icon(Icons.language, color: primary),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black87),
              iconEnabledColor: primary,
              items: languages
                  .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (v) => setState(() => _language = v),
              validator: (v) => v == null ? 'Lütfen seçin' : null,
            ),
            const SizedBox(height: 32),

            // Bildirim Ayarları
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: 'Günlük Görev Hatırlatmaları',
                    subtitle: 'Her sabah görevlerin için hatırlanırsın.',
                    value: widget.data.notifyDailyTasks,
                    onChanged: (v) =>
                        setState(() => widget.data.notifyDailyTasks = v),
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    title: 'AI Plan Önerileri',
                    subtitle: 'Haftalık AI tabanlı önerilerle odaklan.',
                    value: widget.data.notifyAIRecommendations,
                    onChanged: (v) =>
                        setState(() => widget.data.notifyAIRecommendations = v),
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    title: 'Topluluk Davetleri',
                    subtitle: 'Arkadaş davetlerini kaçırma.',
                    value: widget.data.notifyCommunityInvites,
                    onChanged: (v) =>
                        setState(() => widget.data.notifyCommunityInvites = v),
                  ),
                  _buildDivider(),
                  _buildSwitchTile(
                    title: 'Haftalık Raporlar',
                    subtitle: 'Her hafta ilerleme raporunu al.',
                    value: widget.data.notifyWeeklyReport,
                    onChanged: (v) =>
                        setState(() => widget.data.notifyWeeklyReport = v),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ContinueButton(
        onBack: widget.onBack,
        onNext: _next,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      activeColor: ClarxCoreApp.primaryColor,
      onChanged: onChanged,
    );
  }

  Widget _buildDivider() => const Divider(height: 1);
}
