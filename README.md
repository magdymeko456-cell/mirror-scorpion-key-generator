# Mirror Scorpion Key Generator 🔐

تطبيق Flutter متقدم لتوليد مفاتيح تفعيل آمنة باستخدام تقنيات التشفير.

## المميزات ✨

- **توليد مفاتيح آمنة**: استخدام تقنية XOR المتقدمة للتشفير
- **دعم صلاحيات متعددة**: شهر واحد، 3 أشهر، أو سنة واحدة
- **كشف معرف الجهاز**: اكتشاف تلقائي لمعرف الجهاز على Android و iOS
- **واجهة مستخدم حديثة**: تصميم داكن احترافي باستخدام Material Design 3
- **نسخ سريع**: انسخ المفاتيح بسهولة إلى الحافظة
- **تخزين محلي**: حفظ المفاتيح المُولدة باستخدام SharedPreferences
- **واجهة عربية**: دعم كامل للغة العربية

## البنية المعمارية 🏗️

```
lib/
├── main.dart                          # نقطة الدخول للتطبيق
├── screens/
│   └── home_screen.dart               # الشاشة الرئيسية
├── services/
│   ├── premium_verification_service.dart  # خدمة توليد المفاتيح
│   └── key_storage_service.dart           # خدمة التخزين المحلي
└── widgets/
    ├── key_generator_widget.dart      # واجهة توليد المفاتيح
    └── generated_keys_widget.dart     # واجهة عرض المفاتيح المُولدة
```

## المتطلبات 📋

- Flutter >= 3.0.0
- Dart >= 3.0.0
- Android SDK أو Xcode (لـ iOS)

## التثبيت والتشغيل 🚀

### 1. استنساخ المستودع
```bash
git clone https://github.com/magdymeko456-cell/mirror-scorpion-key-generator.git
cd mirror-scorpion-key-generator
```

### 2. تثبيت المتطلبات
```bash
flutter pub get
```

### 3. تشغيل التطبيق
```bash
flutter run
```

## خدمات المشروع 🔧

### PremiumVerificationService
خدمة رئيسية لتوليد مفاتيح التفعيل الآمنة:

```dart
final service = PremiumVerificationService();
String code = service.generateActivationCode(
  'device_id_123',
  durationMonths: 12,
);
```

### KeyStorageService
خدمة للتخزين المحلي والإدارة:

```dart
final storage = KeyStorageService();
await storage.saveKey({'code': code, 'deviceId': id});
List keys = await storage.getStoredKeys();
```

## تقنيات التشفير 🔐

التطبيق يستخدم:
- **XOR Encryption**: تشفير XOR متقدم مع مفتاح آمن
- **Base64 Encoding**: ترميز Base64 لآمان أفضل
- **Dynamic Shifting**: إزاحة ديناميكية لكل بايت

## الاعتماديات 📦

```yaml
dependencies:
  flutter:
    sdk: flutter
  device_info_plus: ^9.0.0        # كشف معرف الجهاز
  shared_preferences: ^2.2.0      # التخزين المحلي
  intl: ^0.20.2                   # الترجمة والتوطين
```

## الميزات المستقبلية 🎯

- [ ] دعم قواعد البيانات السحابية
- [ ] نظام التحقق من المفاتيح
- [ ] إحصائيات متقدمة
- [ ] تصدير المفاتيح
- [ ] نسخ احتياطية معشرة
- [ ] دعم قاعدة البيانات المحلية

## المساهمة 🤝

نرحب بالمساهمات! يرجى:
1. Fork المستودع
2. إنشاء فرع للميزة الجديدة
3. إرسال Pull Request

## الترخيص 📄

هذا المشروع مرخص تحت MIT License

## التواصل 📧

- GitHub: [@magdymeko456-cell](https://github.com/magdymeko456-cell)

---

**صُنع بـ ❤️ باستخدام Flutter**
