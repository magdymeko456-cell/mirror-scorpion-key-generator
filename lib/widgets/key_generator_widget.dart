import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class KeyGeneratorWidget extends StatefulWidget {
  final Function(String deviceId, int durationMonths) onGenerate;

  const KeyGeneratorWidget({
    Key? key,
    required this.onGenerate,
  }) : super(key: key);

  @override
  State<KeyGeneratorWidget> createState() => _KeyGeneratorWidgetState();
}

class _KeyGeneratorWidgetState extends State<KeyGeneratorWidget> {
  final _deviceIdController = TextEditingController();
  int _selectedDuration = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDeviceId();
  }

  Future<void> _loadDeviceId() async {
    setState(() => _isLoading = true);
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String deviceId = '';

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'unknown';
      }

      setState(() {
        _deviceIdController.text = deviceId;
      });
    } catch (e) {
      // Default device ID if automatic detection fails
      _deviceIdController.text = 'DEVICE_\${DateTime.now().millisecondsSinceEpoch}';
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _generateKey() {
    if (_deviceIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ الرجاء إدخال معرّف الجهاز')),
      );
      return;
    }

    widget.onGenerate(_deviceIdController.text, _selectedDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0f3460),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade400, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Device ID Input
          const Text(
            'معرّف الجهاز',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _deviceIdController,
            readOnly: _isLoading,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'أدخل معرّف الجهاز...',
              hintStyle: TextStyle(color: Colors.white30),
              prefixIcon: Icon(Icons.devices, color: Colors.deepPurple.shade400),
              suffixIcon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.refresh, color: Colors.deepPurple.shade400),
                      onPressed: _loadDeviceId,
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.deepPurple.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.deepPurple.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.purple.shade300, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Duration Selection
          const Text(
            'مدة الصلاحية',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildDurationButton(1, 'شهر واحد'),
                const SizedBox(width: 12),
                _buildDurationButton(3, '3 أشهر'),
                const SizedBox(width: 12),
                _buildDurationButton(12, 'سنة واحدة'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Generate Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _generateKey,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade600,
                disabledBackgroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                _isLoading ? Icons.hourglass_empty : Icons.vpn_key,
                color: Colors.white,
              ),
              label: Text(
                _isLoading ? 'جاري التحميل...' : 'توليد المفتاح',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationButton(int duration, String label) {
    final isSelected = _selectedDuration == duration;
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minWidth: 100),
        child: ElevatedButton(
          onPressed: () => setState(() => _selectedDuration = duration),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isSelected ? Colors.deepPurple.shade500 : Colors.grey.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }
}
