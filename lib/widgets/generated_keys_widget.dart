import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneratedKeysWidget extends StatelessWidget {
  final List<Map<String, dynamic>> keys;

  const GeneratedKeysWidget({
    Key? key,
    required this.keys,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ تم النسخ إلى الحافظة'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  String _getDurationLabel(int months) {
    switch (months) {
      case 3:
        return '3 أشهر';
      case 12:
        return 'سنة واحدة';
      default:
        return 'شهر واحد';
    }
  }

  String _formatTime(DateTime dateTime) {
    return '\${dateTime.hour}:\${dateTime.minute.toString().padLeft(2, '0')} - \${dateTime.day}/\${dateTime.month}/\${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final keyData = keys[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0f3460),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade700, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Key Code
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مفتاح التفعيل',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          keyData['code'] ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreenAccent,
                            fontFamily: 'Courier',
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _copyToClipboard(context, keyData['code'] ?? ''),
                    icon: const Icon(Icons.copy, color: Colors.lightGreenAccent),
                    tooltip: 'نسخ المفتاح',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white12),
              const SizedBox(height: 12),

              // Device ID
              Row(
                children: [
                  const Icon(Icons.devices, color: Colors.white54, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'معرّف الجهاز',
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          keyData['deviceId'] ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontFamily: 'Courier',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Duration and Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white54, size: 16),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'الصلاحية',
                            style: TextStyle(fontSize: 12, color: Colors.white54),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _getDurationLabel(keyData['duration'] ?? 1),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'التوقيت',
                        style: TextStyle(fontSize: 12, color: Colors.white54),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatTime(keyData['createdAt'] ?? DateTime.now()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
