import 'package:flutter/material.dart';  
import 'package:flutter/services.dart';  
import 'package:flutter_localizations/flutter_localizations.dart';  
import 'services/premium_verification_service.dart';  
  
void main() {  
  runApp(const KeyGeneratorApp());  
}  
  
class KeyGeneratorApp extends StatelessWidget {  
  const KeyGeneratorApp({super.key});  
  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'Mirror Scorpion Key Generator',  
      debugShowCheckedModeBanner: false,  
      localizationsDelegates: const [  
        GlobalMaterialLocalizations.delegate,  
        GlobalWidgetsLocalizations.delegate,  
        GlobalCupertinoLocalizations.delegate,  
      ],  
      supportedLocales: const [  
        Locale('ar', ''),  
        Locale('en', ''),  
      ],  
      theme: ThemeData(  
        brightness: Brightness.dark,  
        primaryColor: Colors.amber,  
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),  
      ),  
      home: const KeyGeneratorScreen(),  
    );  
  }  
}  
  
class KeyGeneratorScreen extends StatefulWidget {  
  const KeyGeneratorScreen({super.key});  
  
  @override  
  State<KeyGeneratorScreen> createState() => _KeyGeneratorScreenState();  
}  
  
class _KeyGeneratorScreenState extends State<KeyGeneratorScreen> {  
  final TextEditingController _deviceIdController = TextEditingController();  
  final PremiumVerificationService _premiumService = PremiumVerificationService();  
  String _generatedCode = '';  
  int _selectedDuration = 1; // 1 = month, 3 = 3 months, 12 = 1 year  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text(  
          'مولد أكواد التفعيل',  
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),  
        ),  
        backgroundColor: Colors.black,  
        centerTitle: true,  
        elevation: 0,  
      ),  
      body: Container(  
        padding: const EdgeInsets.all(20),  
        decoration: const BoxDecoration(  
          gradient: LinearGradient(  
            begin: Alignment.topCenter,  
            end: Alignment.bottomCenter,  
            colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],  
          ),  
        ),  
        child: SingleChildScrollView(  
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [  
              // Header  
              Container(  
                padding: const EdgeInsets.all(20),  
                decoration: BoxDecoration(  
                  gradient: LinearGradient(  
                    colors: [Colors.amber.shade700.withOpacity(0.2), Colors.orange.withOpacity(0.1)],  
                  ),  
                  borderRadius: BorderRadius.circular(12),  
                  border: Border.all(color: Colors.amber.shade600.withOpacity(0.3)),  
                ),  
                child: Row(  
                  children: [  
                    Icon(Icons.vpn_key, color: Colors.amber.shade300, size: 32),  
                    const SizedBox(width: 12),  
                    Expanded(  
                      child: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [  
                          const Text(  
                            'أداة المطور',  
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),  
                          ),  
                          Text(  
                            'توليد أكواد تفعيل النسخة البرو',  
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),  
                          ),  
                        ],  
                      ),  
                    ),  
                  ],  
                ),  
              ),  
              const SizedBox(height: 30),  
  
              // Device ID Input  
              const Text(  
                'معرف الجهاز المشفر (Device ID):',  
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),  
              ),  
              const SizedBox(height: 10),  
              TextField(  
                controller: _deviceIdController,  
                style: const TextStyle(color: Colors.white),  
                maxLines: 3,  
                decoration: InputDecoration(  
                  hintText: 'ألصق معرف الجهاز هنا...',  
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),  
                  filled: true,  
                  fillColor: Colors.white.withOpacity(0.05),  
                  border: OutlineInputBorder(  
                    borderRadius: BorderRadius.circular(12),  
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),  
                  ),  
                  focusedBorder: OutlineInputBorder(  
                    borderRadius: BorderRadius.circular(12),  
                    borderSide: BorderSide(color: Colors.amber.shade600),  
                  ),  
                ),  
              ),  
              const SizedBox(height: 20),  
  
              // Duration Selection  
              const Text(  
                'مدة الاشتراك:',  
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),  
              ),  
              const SizedBox(height: 10),  
              Row(  
                children: [  
                  Expanded(child: _buildDurationButton('شهر', 1)),  
                  const SizedBox(width: 10),  
                  Expanded(child: _buildDurationButton('3 أشهر', 3)),  
                  const SizedBox(width: 10),  
                  Expanded(child: _buildDurationButton('سنة', 12)),  
                ],  
              ),  
              const SizedBox(height: 30),  
  
              // Generate Button  
              SizedBox(  
                width: double.infinity,  
                child: ElevatedButton(  
                  onPressed: () {  
                    if (_deviceIdController.text.isNotEmpty) {  
                      setState(() {  
                        _generatedCode = _premiumService.generateActivationCode(  
                          _deviceIdController.text.trim(),  
                          durationMonths: _selectedDuration,  
                        );  
                      });  
                    } else {  
                      ScaffoldMessenger.of(context).showSnackBar(  
                        const SnackBar(content: Text('الرجاء إدخال معرف الجهاز')),  
                      );  
                    }  
                  },  
                  style: ElevatedButton.styleFrom(  
                    backgroundColor: Colors.amber.shade600,  
                    padding: const EdgeInsets.symmetric(vertical: 16),  
                    shape: RoundedRectangleBorder(  
                      borderRadius: BorderRadius.circular(12),  
                    ),  
                  ),  
                  child: const Text(  
                    'توليد كود التفعيل',  
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),  
                  ),  
                ),  
              ),  
  
              // Generated Code Display  
              if (_generatedCode.isNotEmpty) ...[  
                const SizedBox(height: 30),  
                Container(  
                  padding: const EdgeInsets.all(20),  
                  decoration: BoxDecoration(  
                    gradient: LinearGradient(  
                      colors: [Colors.green.shade700.withOpacity(0.2), Colors.teal.withOpacity(0.1)],  
                    ),  
                    borderRadius: BorderRadius.circular(12),  
                    border: Border.all(color: Colors.green.shade600.withOpacity(0.3)),  
                  ),  
                  child: Column(  
                    crossAxisAlignment: CrossAxisAlignment.start,  
                    children: [  
                      Row(  
                        children: [  
                          Icon(Icons.check_circle, color: Colors.green.shade300, size: 24),  
                          const SizedBox(width: 8),  
                          const Text(  
                            'تم التوليد بنجاح!',  
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),  
                          ),  
                        ],  
                      ),  
                      const SizedBox(height: 15),  
                      const Text(  
                        'كود التفعيل:',  
                        style: TextStyle(color: Colors.white70, fontSize: 12),  
                      ),  
                      const SizedBox(height: 8),  
                      SelectableText(  
                        _generatedCode,  
                        style: const TextStyle(  
                          color: Colors.amber,  
                          fontSize: 16,  
                          fontWeight: FontWeight.bold,  
                          fontFamily: 'monospace',  
                        ),  
                      ),  
                      const SizedBox(height: 15),  
                      Row(  
                        children: [  
                          Expanded(  
                            child: ElevatedButton.icon(  
                              onPressed: () {  
                                Clipboard.setData(ClipboardData(text: _generatedCode));  
                                ScaffoldMessenger.of(context).showSnackBar(  
                                  const SnackBar(content: Text('تم نسخ كود التفعيل')),  
                                );  
                              },  
                              icon: const Icon(Icons.copy, size: 18),  
                              label: const Text('نسخ'),  
                              style: ElevatedButton.styleFrom(  
                                backgroundColor: Colors.white.withOpacity(0.1),  
                                foregroundColor: Colors.white,  
                              ),  
                            ),  
                          ),  
                          const SizedBox(width: 10),  
                          Expanded(  
                            child: Text(  
                              _getDurationText(),  
                              style: const TextStyle(color: Colors.white70, fontSize: 12),  
                              textAlign: TextAlign.center,  
                            ),  
                          ),  
                        ],  
                      ),  
                    ],  
                  ),  
                ),  
              ],  
  
              const SizedBox(height: 40),  
  
              // Contact Information  
              Container(  
                padding: const EdgeInsets.all(20),  
                decoration: BoxDecoration(  
                  color: Colors.white.withOpacity(0.05),  
                  borderRadius: BorderRadius.circular(12),  
                ),  
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [  
                    Row(  
                      children: [  
                        Icon(Icons.contact_phone, color: Colors.amber.shade300, size: 20),  
                        const SizedBox(width: 8),  
                        const Text(  
                          'معلومات التواصل',  
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),  
                        ),  
                      ],  
                    ),  
                    const SizedBox(height: 15),  
                    _buildContactItem('واتساب', '01017341250'),  
                    _buildContactItem('واتساب', '01031680816'),  
                    _buildContactItem('واتساب', '01558203456'),  
                    _buildContactItem('إيميل', 'dosoky.server@gmail.com'),  
                    _buildContactItem('موقع', 'https://mirrorscapan-p4xjxfkj.manus.space/'),  
                  ],  
                ),  
              ),  
  
              const SizedBox(height: 20),  
              Center(  
                child: Text(  
                  'المطور: Tamer Eldosoky',  
                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),  
                ),  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
  
  Widget _buildDurationButton(String label, int value) {  
    return ElevatedButton(  
      onPressed: () {  
        setState(() {  
          _selectedDuration = value;  
        });  
      },  
      style: ElevatedButton.styleFrom(  
        backgroundColor: _selectedDuration == value   
            ? Colors.amber.shade600   
            : Colors.white.withOpacity(0.1),  
        padding: const EdgeInsets.symmetric(vertical: 12),  
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(8),  
        ),  
      ),  
      child: Text(  
        label,  
        style: TextStyle(  
          color: _selectedDuration == value ? Colors.white : Colors.white70,  
          fontWeight: _selectedDuration == value ? FontWeight.bold : FontWeight.normal,  
        ),  
      ),  
    );  
  }  
  
  Widget _buildContactItem(String label, String value) {  
    return Padding(  
      padding: const EdgeInsets.only(bottom: 8),  
      child: Row(  
        children: [  
          SizedBox(  
            width: 60,  
            child: Text(  
              label,  
              style: TextStyle(color: Colors.amber.shade300, fontSize: 12),  
            ),  
          ),  
          Expanded(  
            child: SelectableText(  
              value,  
              style: const TextStyle(color: Colors.white70, fontSize: 12),  
            ),  
          ),  
        ],  
      ),  
    );  
  }  
  
  String _getDurationText() {  
    switch (_selectedDuration) {  
      case 3:  
        return 'صالح لمدة 3 أشهر';  
      case 12:  
        return 'صالح لمدة سنة';  
      default:  
        return 'صالح لمدة شهر';  
    }  
  }  
}  
