// lib/screens/register_pages/step10_security_permissions.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';

class Step10SecurityPermissions extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step10SecurityPermissions({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step10SecurityPermissionsState createState() =>
      _Step10SecurityPermissionsState();
}

class _Step10SecurityPermissionsState extends State<Step10SecurityPermissions> {
  late bool _biometricAuth;
  late bool _gpsPermission;
  late bool _micPermission;
  late bool _apiAccess;

  @override
  void initState() {
    super.initState();
    _biometricAuth = widget.data.biometricAuth;
    _gpsPermission = widget.data.gpsPermission;
    _micPermission = widget.data.micPermission;
    _apiAccess = widget.data.apiAccess;
  }

  void _next() {
    widget.data
      ..biometricAuth = _biometricAuth
      ..gpsPermission = _gpsPermission
      ..micPermission = _micPermission
      ..apiAccess = _apiAccess;
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
            '🔒 Güvenlik & İzinler',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),

          SwitchListTile(
            title: const Text('Biyometrik Giriş (Touch/Face ID)'),
            value: _biometricAuth,
            onChanged: (v) => setState(() => _biometricAuth = v),
          ),

          SwitchListTile(
            title: const Text('GPS & Konum İzni'),
            subtitle: const Text('Navigasyon ve dış mekan aktiviteleri için'),
            value: _gpsPermission,
            onChanged: (v) => setState(() => _gpsPermission = v),
          ),

          SwitchListTile(
            title: const Text('Mikrofon İzni'),
            subtitle: const Text('Sesli koçluk / rehberlik için'),
            value: _micPermission,
            onChanged: (v) => setState(() => _micPermission = v),
          ),

          SwitchListTile(
            title: const Text('Akıllı Cihaz & API Erişim Onayı'),
            value: _apiAccess,
            onChanged: (v) => setState(() => _apiAccess = v),
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
