import 'package:flutter/material.dart';
import 'package:mirror_scorpion_key_generator/screens/home_screen.dart';

void main() {
  runApp(const MirrorScorpionApp());
}

class MirrorScorpionApp extends StatelessWidget {
  const MirrorScorpionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirror Scorpion Key Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF1a1a2e),
        ),
        scaffoldBackgroundColor: const Color(0xFF16213e),
      ),
      home: const HomeScreen(),
    );
  }
}
