import 'package:calculator/components/seed_color.dart';
import 'package:calculator/views/gemini.dart';
import 'package:calculator/views/home_page.dart';
import 'package:calculator/views/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // State variable for theme mode

  void _toggleTheme(bool newValue) {
    setState(() {
      _isDarkMode = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: Colors.blue,
      darkTheme: ThemeData.light(
        
      ),
      theme: ThemeData.light(
        useMaterial3: true
      ), // Use the selected theme
      themeMode: ThemeMode.system, // Follow system preference for initial theme
      home: const SplashPage(), // Use your desired initial page
      
    );
  }
}
