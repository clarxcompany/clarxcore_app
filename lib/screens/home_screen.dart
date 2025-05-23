// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/app_navigation.dart';
import '../widgets/home_header.dart';
import '../widgets/date_selector.dart';
import '../widgets/live_section.dart';
import '../widgets/home_tabs.dart';
import 'favorites_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNav = 0;
  bool _isMenuOpen = false;

  Future<void> _toggleMenu() async {
    if (!_isMenuOpen) {
      setState(() => _isMenuOpen = true);
      final result = await showGeneralDialog<String>(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black26,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, __, ___) => Stack(
          children: [
            Positioned(
              bottom: 160,
              left: 24,
              right: 24,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMenuItem(
                          Icons.task_alt,
                          'Günlük Görevler',
                          'Günlük görevlerin listesi',
                          'daily'),
                      const Divider(height: 1),
                      _buildMenuItem(
                          Icons.fitness_center,
                          'Spor',
                          'Spor aktivite seçenekleri',
                          'sports'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        transitionBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      );
      setState(() => _isMenuOpen = false);
      if (result == 'daily') setState(() => _selectedNav = 1);
      if (result == 'sports') setState(() => _selectedNav = 3);
    } else {
      Navigator.of(context).pop();
    }
  }

  ListTile _buildMenuItem(
      IconData icon, String title, String subtitle, String value) {
    return ListTile(
      leading: Icon(icon, color: ClarxCoreApp.primaryColor, size: 28),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle,
          style: TextStyle(
              color: ClarxCoreApp.textColor.withOpacity(0.7))),
      onTap: () => Navigator.of(context).pop(value),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (_selectedNav) {
      case 0:
        content = ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            const HomeHeader(userName: 'Binali'),
            const SizedBox(height: 16),
            DateSelector(
              accountOpenedAt:
              DateTime.now().subtract(const Duration(days: 30)),
              completedDates: {
                DateTime.now().subtract(const Duration(days: 2)),
                DateTime.now().subtract(const Duration(days: 1)),
              },
            ),
            const SizedBox(height: 16),
            const LiveSection(),
            const SizedBox(height: 24),
            const HomeTabs(),
          ],
        );
        break;
      case 1:
        content = const FavoritesPage();
        break;
      case 2:
        content = Container(); // Topluluk placeholder
        break;
      case 3:
        content = const ProfilePage();
        break;
      default:
        content = Container();
    }

    return Scaffold(
      extendBody: true,
      body: content,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _selectedNav == 0
          ? Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FloatingActionButton.extended(
          onPressed: _toggleMenu,
          icon: Icon(
              _isMenuOpen ? Icons.close : Icons.menu,
              color: Colors.white),
          label: Text(_isMenuOpen ? 'Çık' : 'Menu',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: ClarxCoreApp.primaryColor,
          elevation: 4,
        ),
      )
          : null,
      bottomNavigationBar: AppNavigation(
        selectedIndex: _selectedNav,
        onTap: (i) => setState(() => _selectedNav = i),
      ),
    );
  }
}
