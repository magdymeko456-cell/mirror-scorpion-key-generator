import 'package:flutter/material.dart';
import 'package:mirror_scorpion_key_generator/services/premium_verification_service.dart';
import 'package:mirror_scorpion_key_generator/widgets/key_generator_widget.dart';
import 'package:mirror_scorpion_key_generator/widgets/generated_keys_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PremiumVerificationService _verificationService =
      PremiumVerificationService();
  final List<Map<String, dynamic>> _generatedKeys = [];

  void _generateKey(String deviceId, int durationMonths) {
    final code = _verificationService.generateActivationCode(
      deviceId,
      durationMonths: durationMonths,
    );

    setState(() {
      _generatedKeys.insert(0, {
        'code': code,
        'deviceId': deviceId,
        'duration': durationMonths,
        'createdAt': DateTime.now(),
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ تم توليد المفتاح بنجاح'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مولد المفاتيح - Mirror Scorpion',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade700, Colors.purple.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'أداة توليد مفاتيح التفعيل',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ولد مفاتيح تفعيل آمنة مع دعم صلاحيات متعددة',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Key Generator
            KeyGeneratorWidget(
              onGenerate: _generateKey,
            ),
            const SizedBox(height: 24),

            // Generated Keys List
            if (_generatedKeys.isNotEmpty) ...
              [
                const Text(
                  'المفاتيح المُولدة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                GeneratedKeysWidget(
                  keys: _generatedKeys,
                ),
              ]
            else
              Container(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.vpn_key_off,
                        size: 64,
                        color: Colors.white30,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'لا توجد مفاتيح مُولدة بعد',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
