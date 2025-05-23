// lib/screens/register_pages/step4_advanced_sport_task_data.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';

class Step4AdvancedSportTaskData extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step4AdvancedSportTaskData({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step4AdvancedSportTaskDataState createState() =>
      _Step4AdvancedSportTaskDataState();
}

class _Step4AdvancedSportTaskDataState
    extends State<Step4AdvancedSportTaskData> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dailyStepsCtrl;
  late TextEditingController _weeklyActivityCtrl;
  late TextEditingController _shortTermCtrl;
  late TextEditingController _longTermCtrl;
  String? _experienceLevel;
  final List<String> _experienceOptions = [
    'Yeni Başlayan',
    'Düzenli',
    'İleri'
  ];
  final List<String> _healthConditionsOptions = [
    'Kronik',
    'Sakatlık',
    'Diğer'
  ];
  final List<String> _selectedHealthConditions = [];
  late TextEditingController _workScheduleCtrl;
  String _groupSolo = 'Solo';
  final List<String> _groupSoloOptions = ['Solo', 'Grup'];
  bool _allowSocialShare = false;

  @override
  void initState() {
    super.initState();
    _dailyStepsCtrl = TextEditingController(
        text: widget.data.dailyStepGoal.toString());
    _weeklyActivityCtrl = TextEditingController(
        text: widget.data.weeklyActivityGoal.toString());
    _shortTermCtrl =
        TextEditingController(text: widget.data.shortTermGoals.join(', '));
    _longTermCtrl =
        TextEditingController(text: widget.data.longTermGoals.join(', '));
    _experienceLevel = widget.data.experienceLevel;
    _selectedHealthConditions.addAll(widget.data.healthConditions);
    _workScheduleCtrl =
        TextEditingController(text: widget.data.workSchedule);
    _groupSolo = widget.data.groupSoloPreference;
    _allowSocialShare = widget.data.allowSocialShare;
  }

  @override
  void dispose() {
    _dailyStepsCtrl.dispose();
    _weeklyActivityCtrl.dispose();
    _shortTermCtrl.dispose();
    _longTermCtrl.dispose();
    _workScheduleCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;

    widget.data
      ..dailyStepGoal = int.parse(_dailyStepsCtrl.text)
      ..weeklyActivityGoal = int.parse(_weeklyActivityCtrl.text)
      ..shortTermGoals = _shortTermCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList()
      ..longTermGoals = _longTermCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList()
      ..experienceLevel = _experienceLevel!
      ..healthConditions = List.from(_selectedHealthConditions)
      ..workSchedule = _workScheduleCtrl.text.trim()
      ..groupSoloPreference = _groupSolo
      ..allowSocialShare = _allowSocialShare;

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '❤️ Gelişmiş Spor & Görev Verileri',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              // Günlük Adım Hedefi
              TextFormField(
                controller: _dailyStepsCtrl,
                decoration: const InputDecoration(
                  labelText: 'Günlük Adım Hedefi',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) =>
                v!.isEmpty ? 'Günlük adım hedefi girin' : null,
              ),
              const SizedBox(height: 12),

              // Haftalık Hareket Süresi Hedefi
              TextFormField(
                controller: _weeklyActivityCtrl,
                decoration: const InputDecoration(
                  labelText: 'Haftalık Hareket Süresi (dakika)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) =>
                v!.isEmpty ? 'Haftalık süre girin' : null,
              ),
              const SizedBox(height: 12),

              // Kısa Vadeli Hedefler
              TextFormField(
                controller: _shortTermCtrl,
                decoration: const InputDecoration(
                  labelText: 'Kısa Vadeli Hedefler (virgülle ayırın)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Uzun Vadeli Hedefler
              TextFormField(
                controller: _longTermCtrl,
                decoration: const InputDecoration(
                  labelText: 'Uzun Vadeli Hedefler (virgülle ayırın)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Deneyim Seviyesi
              DropdownButtonFormField<String>(
                value: _experienceLevel,
                decoration: const InputDecoration(
                  labelText: 'Geçmiş Deneyim Seviyesi',
                  border: OutlineInputBorder(),
                ),
                items: _experienceOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _experienceLevel = v),
                validator: (v) =>
                v == null ? 'Deneyim seviyesi seçin' : null,
              ),
              const SizedBox(height: 12),

              // Sağlık Durumu & Engeller
              Text('Sağlık Durumu & Engeller'),
              Wrap(
                spacing: 8,
                children: _healthConditionsOptions.map((cond) {
                  final sel = _selectedHealthConditions.contains(cond);
                  return FilterChip(
                    label: Text(cond),
                    selected: sel,
                    onSelected: (on) {
                      setState(() {
                        if (on) {
                          _selectedHealthConditions.add(cond);
                        } else {
                          _selectedHealthConditions.remove(cond);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Mesleki Program & Esneklik
              TextFormField(
                controller: _workScheduleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Mesleki Program & Esneklik',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Grup vs Solo Çalışma Tercihi
              DropdownButtonFormField<String>(
                value: _groupSolo,
                decoration: const InputDecoration(
                  labelText: 'Grup vs Solo Tercihi',
                  border: OutlineInputBorder(),
                ),
                items: _groupSoloOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _groupSolo = v!),
              ),
              const SizedBox(height: 12),

              // Sosyal Paylaşım İzni
              SwitchListTile(
                title: const Text('Sosyal Paylaşım İzni'),
                value: _allowSocialShare,
                onChanged: (v) =>
                    setState(() => _allowSocialShare = v),
              ),

              const SizedBox(height: 24),

              // Geri / İleri Butonları
              Row(
                children: [
                  TextButton(onPressed: widget.onBack, child: const Text('Geri')),
                  const Spacer(),
                  ElevatedButton(onPressed: _next, child: const Text('İleri')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
