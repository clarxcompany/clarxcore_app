// lib/screens/register_pages/step8_community_settings.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';

class Step8CommunitySettings extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step8CommunitySettings({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step8CommunitySettingsState createState() =>
      _Step8CommunitySettingsState();
}

class _Step8CommunitySettingsState extends State<Step8CommunitySettings> {
  late bool _allowFriendRequests;
  late bool _joinTeamTasks;
  late bool _leaderboardVisibility;
  late List<String> _selectedGroups;

  final List<String> _availableGroups = [
    'Koşu',
    'Bisiklet',
    'Yüzme',
    'Yoga',
    'Pilates',
    'Yazılım',
    'Blockchain',
  ];

  @override
  void initState() {
    super.initState();
    _allowFriendRequests = widget.data.allowFriendRequests;
    _joinTeamTasks = widget.data.joinTeamTasks;
    _leaderboardVisibility = widget.data.leaderboardVisibility;
    _selectedGroups = List.from(widget.data.communityGroups);
  }

  void _next() {
    widget.data
      ..allowFriendRequests = _allowFriendRequests
      ..joinTeamTasks = _joinTeamTasks
      ..leaderboardVisibility = _leaderboardVisibility
      ..communityGroups = List.from(_selectedGroups);
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
            '🤝 Sosyal & Topluluk Ayarları',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),

          SwitchListTile(
            title: const Text('Arkadaş Ekleme / Takip İzni'),
            value: _allowFriendRequests,
            onChanged: (v) => setState(() => _allowFriendRequests = v),
          ),

          SwitchListTile(
            title: const Text('Takım Görevlerine Katılma'),
            value: _joinTeamTasks,
            onChanged: (v) => setState(() => _joinTeamTasks = v),
          ),

          SwitchListTile(
            title: const Text('Lider Tablo Görünürlüğü'),
            value: _leaderboardVisibility,
            onChanged: (v) => setState(() => _leaderboardVisibility = v),
          ),

          const SizedBox(height: 16),
          const Text(
            'Topluluk Gruplarına Katılma',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            children: _availableGroups.map((grp) {
              final selected = _selectedGroups.contains(grp);
              return FilterChip(
                label: Text(grp),
                selected: selected,
                onSelected: (on) {
                  setState(() {
                    if (on) {
                      _selectedGroups.add(grp);
                    } else {
                      _selectedGroups.remove(grp);
                    }
                  });
                },
              );
            }).toList(),
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
