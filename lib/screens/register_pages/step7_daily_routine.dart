// lib/screens/register_pages/step7_daily_routine.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';

class Step7DailyRoutine extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step7DailyRoutine({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step7DailyRoutineState createState() => _Step7DailyRoutineState();
}

class _Step7DailyRoutineState extends State<Step7DailyRoutine> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay? _wakeTime;
  TimeOfDay? _sleepTime;
  late TextEditingController _workHoursCtrl;
  late TextEditingController _breakPrefsCtrl;
  bool _mealWaterReminders = false;

  @override
  void initState() {
    super.initState();
    _wakeTime = widget.data.wakeTime;
    _sleepTime = widget.data.sleepTime;
    _workHoursCtrl = TextEditingController(text: widget.data.workHours);
    _breakPrefsCtrl = TextEditingController(text: widget.data.breakPreferences);
    _mealWaterReminders = widget.data.mealWaterReminders;
  }

  @override
  void dispose() {
    _workHoursCtrl.dispose();
    _breakPrefsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime(BuildContext context, bool isWake) async {
    final initial = isWake ? (_wakeTime ?? TimeOfDay(hour: 7, minute: 0)) : (_sleepTime ?? TimeOfDay(hour: 23, minute: 0));
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );
    if (picked != null) {
      setState(() {
        if (isWake) _wakeTime = picked;
        else _sleepTime = picked;
      });
    }
  }

  String _format(TimeOfDay? t) =>
      t == null ? '' : t.format(context);

  void _next() {
    if (!_formKey.currentState!.validate() ||
        _wakeTime == null ||
        _sleepTime == null) {
      if (_wakeTime == null || _sleepTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uyanış ve yatış saatlerini seçmelisiniz.')),
        );
      }
      return;
    }
    widget.data
      ..wakeTime = _wakeTime
      ..sleepTime = _sleepTime
      ..workHours = _workHoursCtrl.text.trim()
      ..breakPreferences = _breakPrefsCtrl.text.trim()
      ..mealWaterReminders = _mealWaterReminders;
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
                '⏰ Günlük Rutin & Program Bilgileri',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              // Standart Uyanış Saati
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Standart Uyanış Saati'),
                trailing: Text(
                  _wakeTime != null ? _format(_wakeTime) : 'Seçiniz',
                  style: TextStyle(
                    color: _wakeTime != null ? null : Colors.grey,
                  ),
                ),
                onTap: () => _pickTime(context, true),
              ),
              const SizedBox(height: 12),

              // Standart Yatış Saati
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Standart Yatış Saati'),
                trailing: Text(
                  _sleepTime != null ? _format(_sleepTime) : 'Seçiniz',
                  style: TextStyle(
                    color: _sleepTime != null ? null : Colors.grey,
                  ),
                ),
                onTap: () => _pickTime(context, false),
              ),
              const SizedBox(height: 12),

              // İş / Okul Saatleri
              TextFormField(
                controller: _workHoursCtrl,
                decoration: const InputDecoration(
                  labelText: 'İş / Okul Saatleri',
                  hintText: 'Örn. 09:00 - 17:00',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Gerekli alan' : null,
              ),
              const SizedBox(height: 12),

              // Mola & Dinlenme Tercihleri
              TextFormField(
                controller: _breakPrefsCtrl,
                decoration: const InputDecoration(
                  labelText: 'Mola & Dinlenme Tercihleri',
                  hintText: 'Örn. 5 dk her saat başı',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Gerekli alan' : null,
              ),
              const SizedBox(height: 12),

              // Öğün / Su Hatırlatmaları
              SwitchListTile(
                title: const Text('Öğün / Su Hatırlatmaları'),
                subtitle: const Text('Hatırlatmaları açmak için seçin'),
                value: _mealWaterReminders,
                onChanged: (v) =>
                    setState(() => _mealWaterReminders = v),
              ),

              const SizedBox(height: 24),

              // Geri / İleri Butonları
              Row(
                children: [
                  TextButton(
                    onPressed: widget.onBack,
                    child: const Text('Geri'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _next,
                    child: const Text('İleri'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
