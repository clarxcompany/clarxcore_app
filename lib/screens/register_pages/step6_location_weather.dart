// lib/screens/register_pages/step6_location_weather.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';

class Step6LocationWeather extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step6LocationWeather({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step6LocationWeatherState createState() => _Step6LocationWeatherState();
}

class _Step6LocationWeatherState extends State<Step6LocationWeather> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cityCtrl;
  late bool _autoWeather;

  @override
  void initState() {
    super.initState();
    _cityCtrl = TextEditingController(text: widget.data.cityOrPostal);
    _autoWeather = widget.data.autoWeatherNotification;
  }

  @override
  void dispose() {
    _cityCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    widget.data
      ..cityOrPostal = _cityCtrl.text.trim()
      ..autoWeatherNotification = _autoWeather;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌤️ Konum & Hava Durumu Bilgileri',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),

          Form(
            key: _formKey,
            child: TextFormField(
              controller: _cityCtrl,
              decoration: const InputDecoration(
                labelText: 'Şehir / Posta Kodu',
                border: OutlineInputBorder(),
                hintText: 'Örneğin: İstanbul veya 34000',
              ),
              validator: (v) =>
              v == null || v.trim().isEmpty ? 'Gerekli alan' : null,
            ),
          ),
          const SizedBox(height: 24),

          SwitchListTile(
            title: const Text('Otomatik Hava Durumu Bildirimleri'),
            subtitle: const Text(
                'Dış mekan aktiviteleri için güncel hava durumu uyarıları al'),
            value: _autoWeather,
            onChanged: (v) => setState(() => _autoWeather = v),
          ),

          const Spacer(),

          Row(
            children: [
              TextButton(onPressed: widget.onBack, child: const Text('Geri')),
              const Spacer(),
              ElevatedButton(onPressed: _next, child: const Text('İleri')),
            ],
          ),
        ],
      ),
    );
  }
}
