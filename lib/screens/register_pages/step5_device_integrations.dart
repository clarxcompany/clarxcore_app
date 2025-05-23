// lib/screens/register_pages/step5_device_integrations.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';

class Step5DeviceIntegrations extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step5DeviceIntegrations({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step5DeviceIntegrationsState createState() =>
      _Step5DeviceIntegrationsState();
}

class _Step5DeviceIntegrationsState extends State<Step5DeviceIntegrations> {
  // Takvim entegrasyonları seçenekleri
  final List<String> _allIntegrations = [
    'Google Takvim',
    'Obsidian',
    'Notion',
    'Trello',
  ];

  // Geçici seçim listesi
  late List<String> _selectedIntegrations;
  late bool _syncHealth;
  late bool _wearablePermission;
  late bool _pushNotification;
  late bool _emailNotification;

  @override
  void initState() {
    super.initState();
    _syncHealth = widget.data.syncHealth;
    _wearablePermission = widget.data.wearablePermission;
    _selectedIntegrations = List.from(widget.data.calendarIntegrations);
    _pushNotification = widget.data.pushNotification;
    _emailNotification = widget.data.emailNotification;
  }

  void _next() {
    // Verileri RegisterData'ya yaz
    widget.data
      ..syncHealth = _syncHealth
      ..wearablePermission = _wearablePermission
      ..calendarIntegrations = List.from(_selectedIntegrations)
      ..pushNotification = _pushNotification
      ..emailNotification = _emailNotification;

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
            '📱 Cihaz & Entegrasyon Tercihleri',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),

          // Apple Health / Google Fit Senkronizasyonu
          SwitchListTile(
            title: const Text('Apple Health / Google Fit Senkronizasyonu'),
            value: _syncHealth,
            onChanged: (v) => setState(() => _syncHealth = v),
          ),

          // Akıllı Saat / Wearable Bağlantı İzni
          SwitchListTile(
            title: const Text('Akıllı Saat / Wearable Bağlantı İzni'),
            value: _wearablePermission,
            onChanged: (v) => setState(() => _wearablePermission = v),
          ),

          const SizedBox(height: 16),
          const Text(
            'Takvim & Görev Yönetim Entegrasyonları (isteğe bağlı)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Entegrasyonların çoklu seçimi
          Wrap(
            spacing: 8,
            children: _allIntegrations.map((integration) {
              final selected = _selectedIntegrations.contains(integration);
              return FilterChip(
                label: Text(integration),
                selected: selected,
                onSelected: (on) {
                  setState(() {
                    if (on) {
                      _selectedIntegrations.add(integration);
                    } else {
                      _selectedIntegrations.remove(integration);
                    }
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // Push Bildirimleri
          SwitchListTile(
            title: const Text('Push Bildirimleri'),
            value: _pushNotification,
            onChanged: (v) => setState(() => _pushNotification = v),
          ),

          // E-posta Bildirimleri
          SwitchListTile(
            title: const Text('E-posta Bildirimleri'),
            value: _emailNotification,
            onChanged: (v) => setState(() => _emailNotification = v),
          ),

          const Spacer(),

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
    );
  }
}
