// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'screens/splash_screen.dart';
import 'screens/auth_choice_screen.dart';
import 'screens/register_flow.dart';
import 'screens/login_page.dart';
import 'screens/home_screen.dart';
import 'screens/legal/terms_of_use_page.dart';

/// Tema modunu yöneten notifier
final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sadece ilk kez Firebase'i başlat, sonrasında duplicate-app hatasını yut
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    // duplicate-app veya başka bir hata varsa burası yutar
  }

  runApp(const ClarxCoreApp());
}

class ClarxCoreApp extends StatelessWidget {
  const ClarxCoreApp({Key? key}) : super(key: key);

  static const Color primaryColor    = Color(0xFF1A2E50);
  static const Color secondaryColor  = Color(0xFFA6F0C6);
  static const Color backgroundColor = Colors.white;
  static const Color textColor       = Color(0xFF001A3C);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (_, themeMode, __) {
        return MaterialApp(
          title: 'ClarxCore',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          home: const SplashScreen(),
          routes: {
            '/auth':     (_) => const AuthChoiceScreen(),
            '/register': (_) => const RegisterFlow(),
            '/login':    (_) => const LoginPage(),
            '/home':     (_) => const HomeScreen(),
            '/terms':    (_) => const TermsOfUsePage(),
          },
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: backgroundColor,
            fontFamily: 'Nunito',
            textTheme: TextTheme(
              titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(color: textColor),
            ),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: _createMaterialColor(primaryColor),
            ).copyWith(secondary: secondaryColor),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: Colors.black,
            fontFamily: 'Nunito',
            textTheme: const TextTheme(
              titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(color: Colors.white70),
            ),
            colorScheme: ColorScheme.fromSwatch(
              brightness: Brightness.dark,
              primarySwatch: _createMaterialColor(primaryColor),
            ).copyWith(secondary: secondaryColor),
          ),
        );
      },
    );
  }

  static MaterialColor _createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;
    for (var i = 1; i < 10; i++) strengths.add(0.1 * i);
    for (var s in strengths) {
      final ds = 0.5 - s;
      swatch[(s * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : 255 - r) * ds).round(),
        g + ((ds < 0 ? g : 255 - g) * ds).round(),
        b + ((ds < 0 ? b : 255 - b) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
