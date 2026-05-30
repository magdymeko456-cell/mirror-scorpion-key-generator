import 'dart:convert';
import 'dart:math';

/// Premium Verification Service - Key Generation Only
class PremiumVerificationService {
  static final PremiumVerificationService _instance =
      PremiumVerificationService._internal();

  factory PremiumVerificationService() => _instance;
  PremiumVerificationService._internal();

  /// Generate activation code with duration support
  /// durationMonths: 1 (month), 3 (3 months), 12 (1 year)
  String generateActivationCode(String deviceId, {int durationMonths = 1}) {
    String encryptedId = _encryptId(deviceId);
    String durationSuffix = _getDurationSuffix(durationMonths);
    // Extract first 16 characters for compact code
    String compactEncrypted = encryptedId.substring(0, math.min(16, encryptedId.length));
    return "MS-PRO-$compactEncrypted$durationSuffix";
  }

  /// Get duration suffix based on months
  String _getDurationSuffix(int months) {
    switch (months) {
      case 3:
        return "-3M";
      case 12:
        return "-1Y";
      default:
        return "-1M";
    }
  }

  /// Advanced XOR-based encryption for ID
  String _encryptId(String input) {
    final key = "MIRROR_SCORPION_SECURE_2026";
    List<int> bytes = utf8.encode(input);
    List<int> keyBytes = utf8.encode(key);
    List<int> result = [];
    for (int i = 0; i < bytes.length; i++) {
      int shift = (i * 7) % 256;
      result.add((bytes[i] ^ keyBytes[i % keyBytes.length] ^ shift) % 256);
    }
    return base64.encode(result);
  }

  /// Verify activation code format
  bool verifyCodeFormat(String code) {
    return code.startsWith("MS-PRO-") &&
        (code.endsWith("-1M") || code.endsWith("-3M") || code.endsWith("-1Y"));
  }

  /// Extract device ID from activation code (requires decryption)
  String? extractDeviceIdFromCode(String code) {
    try {
      if (!verifyCodeFormat(code)) return null;

      // Remove prefix and suffix
      String trimmed = code.replaceFirst("MS-PRO-", "");
      String encrypted =
          trimmed.substring(0, trimmed.length - 3); // Remove duration suffix

      // Decode from base64
      List<int> decrypted = base64.decode(encrypted);

      // Reverse XOR encryption
      final key = "MIRROR_SCORPION_SECURE_2026";
      List<int> keyBytes = utf8.encode(key);
      List<int> result = [];

      for (int i = 0; i < decrypted.length; i++) {
        int shift = (i * 7) % 256;
        result.add((decrypted[i] ^ keyBytes[i % keyBytes.length] ^ shift) % 256);
      }

      return utf8.decode(result);
    } catch (e) {
      return null;
    }
  }

  /// Extract duration from activation code
  int extractDurationFromCode(String code) {
    if (code.endsWith("-1Y")) return 12;
    if (code.endsWith("-3M")) return 3;
    return 1;
  }

  /// Validate code authenticity
  bool validateCode(String code, String deviceId) {
    try {
      final extractedId = extractDeviceIdFromCode(code);
      return extractedId == deviceId;
    } catch (e) {
      return false;
    }
  }
}
