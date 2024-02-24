import 'package:calculator/components/seed_color.dart';
import 'package:calculator/views/home_page.dart';
import 'package:calculator/views/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        // brightness: Brightness.dark,
        // colorSchemeSeed: seed,
        primarySwatch: seed,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: seed),
        useMaterial3: true,
        
      ),
      // home: const CalculatorPage(),
      home: const SplashPage(),
    );
  }
}