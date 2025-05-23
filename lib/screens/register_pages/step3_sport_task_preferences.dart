// lib/screens/register_pages/step3_sport_task_preferences.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';
import '../../main.dart';
import 'continue_button.dart';

class Step3SportTaskPreferences extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step3SportTaskPreferences({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step3SportTaskPreferencesState createState() =>
      _Step3SportTaskPreferencesState();
}

class _Step3SportTaskPreferencesState
    extends State<Step3SportTaskPreferences> {
  final _formKey = GlobalKey<FormState>();

  // OPTIONS
  final _allSports = ['Koşu','Bisiklet','Yüzme','Yoga','Ağırlık','HIIT','Pilates'];
  final _allTimeSlots = [
    'Sabah (05:00–10:00)',
    'Öğle (10:00–15:00)',
    'Akşam (15:00–21:00)'
  ];
  final _environments = ['Açık Hava','Kapalı Alan','Ev','Salon'];
  final _motivations = [
    'Puan Sistemi',
    'Rozetler',
    'Arkadaş Yarışmaları',
    'Kişisel Hedef İzleme'
  ];
  final _taskCategories = [
    'Sağlıklı Beslenme',
    'Okuma',
    'Meditasyon',
    'Öğrenme',
    'Sosyal Bağlantı'
  ];

  // SELECTIONS
  final _selSports = <String>[];
  final _selTimeSlots = <String>[];
  String? _selEnv;
  final _selMots = <String>[];

  final _selTasks = <String>[];
  final _priority = <String,int>{};

  late TextEditingController
  _weeklyCtrl,
      _avgCtrl,
      _equipCtrl,
      _dailyCtrl,
      _quickCtrl;
  String _repeatFreq = 'Günlük';
  String _difficulty = 'Orta';

  @override
  void initState() {
    super.initState();
    // initialize controllers
    _weeklyCtrl = TextEditingController(text: widget.data.weeklySessions.toString());
    _avgCtrl     = TextEditingController(text: widget.data.avgSessionDuration.toString());
    _equipCtrl   = TextEditingController(text: widget.data.equipment.join(', '));
    _dailyCtrl   = TextEditingController(text: widget.data.dailyTaskTarget.toString());
    _quickCtrl   = TextEditingController(text: widget.data.quickStartPlans.join(', '));
    _repeatFreq  = widget.data.repeatFrequency;
    _difficulty  = widget.data.difficultyLevel;

    // load previous selections
    _selSports.addAll(widget.data.favoriteSports);
    _selTimeSlots.addAll(widget.data.preferredTimeSlots);
    _selEnv = widget.data.sportEnvironment;
    _selMots.addAll(widget.data.motivations);
    _selTasks.addAll(widget.data.taskCategories);
    widget.data.categoryPriority.forEach((k,v) => _priority[k]=v);
  }

  @override
  void dispose() {
    _weeklyCtrl.dispose();
    _avgCtrl.dispose();
    _equipCtrl.dispose();
    _dailyCtrl.dispose();
    _quickCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    if (_selEnv == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir spor ortamı seçin.')),
      );
      return;
    }
    // write back
    widget.data
      ..favoriteSports      = List.from(_selSports)
      ..weeklySessions      = int.parse(_weeklyCtrl.text)
      ..avgSessionDuration  = int.parse(_avgCtrl.text)
      ..preferredTimeSlots  = List.from(_selTimeSlots)
      ..sportEnvironment    = _selEnv!
      ..equipment           = _equipCtrl.text
          .split(',').map((s)=>s.trim()).where((s)=>s.isNotEmpty).toList()
      ..motivations         = List.from(_selMots)
      ..taskCategories      = List.from(_selTasks)
      ..categoryPriority    = { for (var c in _selTasks) c: _priority[c] ?? 3 }
      ..dailyTaskTarget     = int.parse(_dailyCtrl.text)
      ..repeatFrequency     = _repeatFreq
      ..difficultyLevel     = _difficulty
      ..quickStartPlans     = _quickCtrl.text
          .split(',').map((s)=>s.trim()).where((s)=>s.isNotEmpty).toList();
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final primary = ClarxCoreApp.primaryColor;
    return Scaffold(
      backgroundColor: ClarxCoreApp.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🏅 Spor & Görev Tercihleri',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),

                      // A) Spor Aktiviteleri
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('A) Spor Aktiviteleri',
                                  style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _allSports.map((s) {
                                  final sel = _selSports.contains(s);
                                  return ChoiceChip(
                                    label: Text(s),
                                    selected: sel,
                                    onSelected: (yes) {
                                      setState(() {
                                        yes
                                            ? _selSports.add(s)
                                            : _selSports.remove(s);
                                      });
                                    },
                                    selectedColor: primary.withOpacity(0.2),
                                  );
                                }).toList(),
                              ),
                              if (_selSports.isEmpty) ...[
                                const SizedBox(height: 8),
                                const Text(
                                  'En az bir spor türü seçin.',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                              const SizedBox(height: 16),
                              _buildNumberField(_weeklyCtrl, 'Haftalık Spor Seansı'),
                              const SizedBox(height: 12),
                              _buildNumberField(_avgCtrl, 'Ortalama Seans Süresi (dk)'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // B) Zaman & Ortam & Motivasyon
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('B) Zaman & Ortam & Motivasyon',
                                  style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 12),

                              Text('⏰ Zaman Dilimleri'),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _allTimeSlots.map((t) {
                                  final sel = _selTimeSlots.contains(t);
                                  return FilterChip(
                                    label: Text(t),
                                    selected: sel,
                                    onSelected: (yes) {
                                      setState(() {
                                        yes
                                            ? _selTimeSlots.add(t)
                                            : _selTimeSlots.remove(t);
                                      });
                                    },
                                  );
                                }).toList(),
                              ),

                              const SizedBox(height: 16),
                              _buildDropdown<String>(
                                value: _selEnv,
                                label: 'Spor Ortamı',
                                items: _environments,
                                onChanged: (v) => setState(() => _selEnv = v),
                                validator: (v) =>
                                v == null ? 'Seçim gerekli' : null,
                              ),

                              const SizedBox(height: 16),
                              Text('🎯 Motivasyon Unsurları'),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _motivations.map((m) {
                                  final sel = _selMots.contains(m);
                                  return FilterChip(
                                    label: Text(m),
                                    selected: sel,
                                    onSelected: (yes) {
                                      setState(() {
                                        yes
                                            ? _selMots.add(m)
                                            : _selMots.remove(m);
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // C) Görev Kategorileri
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('C) Görev Kategorileri',
                                  style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _taskCategories.map((c) {
                                  final sel = _selTasks.contains(c);
                                  return FilterChip(
                                    label: Text(c),
                                    selected: sel,
                                    onSelected: (yes) {
                                      setState(() {
                                        if (yes && _selTasks.length < 3) {
                                          _selTasks.add(c);
                                          _priority[c] = 3;
                                        } else if (!yes) {
                                          _selTasks.remove(c);
                                          _priority.remove(c);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              if (_selTasks.isEmpty) ...[
                                const SizedBox(height: 8),
                                const Text(
                                  'En az bir kategori seçin.',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                              const SizedBox(height: 16),
                              // Öncelik
                              ..._selTasks.map((c) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(c)),
                                      DropdownButton<int>(
                                        value: _priority[c],
                                        items: List.generate(5, (i) => i + 1)
                                            .map((p) => DropdownMenuItem(
                                          value: p,
                                          child: Text(p.toString()),
                                        ))
                                            .toList(),
                                        onChanged: (v) => setState(() {
                                          _priority[c] = v!;
                                        }),
                                      ),
                                    ],
                                  ),
                                );
                              }),

                              const SizedBox(height: 16),
                              _buildNumberField(_dailyCtrl, 'Günlük Görev Adedi'),
                              const SizedBox(height: 12),
                              _buildDropdown<String>(
                                value: _repeatFreq,
                                label: 'Tekrar Sıklığı',
                                items: ['Günlük','Haftalık','Aylık'],
                                onChanged: (v) => setState(() => _repeatFreq = v!),
                              ),
                              const SizedBox(height: 12),
                              _buildDropdown<String>(
                                value: _difficulty,
                                label: 'Zorluk Seviyesi',
                                items: ['Kolay','Orta','Zor'],
                                onChanged: (v) => setState(() => _difficulty = v!),
                              ),
                              const SizedBox(height: 12),
                              _buildTextField(
                                controller: _quickCtrl,
                                label: 'Hızlı Başlangıç Planları (virgülle ayırın)',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // NAVIGATION BUTTONS
            ContinueButton(
              onBack: widget.onBack,
              onNext: _next,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNumberField(
      TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (v) => v == null || v.isEmpty ? 'Gerekli' : null,
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String label,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String? Function(T?)? validator,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
