// lib/screens/register_pages/step1_basic_info.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../register_flow.dart';
import '../../main.dart';
import 'continue_button.dart';

class Step1BasicInfo extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step1BasicInfo({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step1BasicInfoState createState() => _Step1BasicInfoState();
}

class _Step1BasicInfoState extends State<Step1BasicInfo> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController
  _nameCtrl,
      _usernameCtrl,
      _emailCtrl,
      _passCtrl,
      _passConfirmCtrl,
      _phoneCtrl,
      _birthDateCtrl;

  DateTime? _birthDate;
  String? _gender;
  bool _obscurePass = true,
      _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _nameCtrl        = TextEditingController(text: widget.data.fullName);
    _usernameCtrl    = TextEditingController(text: widget.data.username);
    _emailCtrl       = TextEditingController(text: widget.data.email);
    _passCtrl        = TextEditingController();
    _passConfirmCtrl = TextEditingController();
    _phoneCtrl       = TextEditingController(text: widget.data.phone);

    _birthDate = widget.data.birthDate;
    _birthDateCtrl = TextEditingController(
      text: _birthDate != null
          ? DateFormat('dd/MM/yyyy').format(_birthDate!)
          : '',
    );

    _gender = widget.data.gender;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _passConfirmCtrl.dispose();
    _phoneCtrl.dispose();
    _birthDateCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final dt = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: ClarxCoreApp.primaryColor),
        ),
        child: child!,
      ),
    );
    if (dt != null) {
      setState(() {
        _birthDate = dt;
        _birthDateCtrl.text = DateFormat('dd/MM/yyyy').format(dt);
      });
    }
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    if (_passCtrl.text != _passConfirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Şifreler eşleşmiyor')),
      );
      return;
    }
    widget.data
      ..fullName  = _nameCtrl.text.trim()
      ..username  = _usernameCtrl.text.trim()
      ..email     = _emailCtrl.text.trim()
      ..password  = _passCtrl.text
      ..phone     = _phoneCtrl.text.trim()
      ..birthDate = _birthDate
      ..gender    = _gender;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (ctx, inner) => [
          SliverAppBar(
            automaticallyImplyLeading: false, // üst sol otomatik geri butonu kaldırıldı
            title: const Text('Kayıt Ol'),
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/register/step1_header.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildField(
                  controller: _nameCtrl,
                  label: 'Ad Soyad',
                  icon: Icons.person,
                  validator: (v) => v!.isEmpty ? 'Gerekli' : null,
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _usernameCtrl,
                  label: 'Kullanıcı Adı',
                  icon: Icons.alternate_email,
                  validator: (v) => v!.isEmpty ? 'Gerekli' : null,
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _emailCtrl,
                  label: 'E-posta Adresi',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v != null && v.contains('@') ? null : 'Geçerli e-posta',
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _passCtrl,
                  label: 'Şifre',
                  icon: Icons.lock,
                  obscureText: _obscurePass,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePass ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePass = !_obscurePass),
                  ),
                  validator: (v) => v != null && v.length >= 6 ? null : '6+ karakter',
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _passConfirmCtrl,
                  label: 'Şifre Onayı',
                  icon: Icons.lock_outline,
                  obscureText: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (v) => v!.isEmpty ? 'Gerekli' : null,
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _phoneCtrl,
                  label: 'Telefon (isteğe bağlı)',
                  icon: Icons.phone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _birthDateCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Doğum Tarihi',
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Gerekli' : null,
                  onTap: _pickBirthDate,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    labelText: 'Cinsiyet (isteğe bağlı)',
                    prefixIcon: const Icon(Icons.transgender),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: ['Erkek', 'Kadın', 'Diğer']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (v) => setState(() => _gender = v),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ContinueButton(
        onBack: widget.onBack,
        onNext: _next,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        fillColor: Colors.grey.shade100,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
