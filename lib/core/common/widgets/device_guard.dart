import 'package:ecommerce_admin_app/core/common/widgets/unsupported_device_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class DeviceGuard extends StatelessWidget {
  final Widget child;

  static const double minDesktopWidth = 1024.0;

  const DeviceGuard({Key? key, required this.child}) : super(key: null);

  bool _isMobileOrTabletDevice() {
    if (!kIsWeb) return false;

    // فحص الـ User-Agent للتأكد إنه مش موبايل أو تابلت
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    bool isMobileUA =
        userAgent.contains('mobi') ||
        userAgent.contains('android') ||
        userAgent.contains('iphone') ||
        userAgent.contains('ipad') ||
        userAgent.contains('tablet');

    return isMobileUA;
  }

  @override
  Widget build(BuildContext context) {
    // 1. فحص العرض الحالي للشاشة
    final screenWidth = MediaQuery.of(context).size.width;

    // 2. فحص الـ User-Agent (لو ويب وموبايل)
    bool isMobile = kIsWeb && _isMobileOrTabletDevice();

    // لو الشاشة أصغر من المسموح أو الجهاز المكتشف موبايل/تابلت
    if (screenWidth < minDesktopWidth || isMobile) {
      return const UnsupportedDeviceScreen();
    }

    return child;
  }
}
