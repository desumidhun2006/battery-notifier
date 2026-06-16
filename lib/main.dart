import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/settings.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final settings = Settings(prefs);
  runApp(BatteryNotifierApp(settings: settings));
}

class BatteryNotifierApp extends StatelessWidget {
  final Settings settings;
  const BatteryNotifierApp({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Notifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      home: HomeScreen(settings: settings),
    );
  }
}
