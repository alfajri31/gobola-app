import 'dart:io';

import 'package:flutter/foundation.dart';

class AppConfig {
  // Use kReleaseMode for Flutter's production detection
  static bool isProduction = bool.fromEnvironment('dart.vm.product') || kReleaseMode;

  static String get baseUrl {
    return isProduction
        ? 'http://ec2-54-255-108-79.ap-southeast-1.compute.amazonaws.com/api'
        : 'http://10.0.2.2:3002/api'; // Android emulator localhost
  }

  // For iOS simulator use 'http://localhost:3001/api'
  static String get platformAwareBaseUrl {
    if (isProduction) {
      return baseUrl;
    }
    return Platform.isAndroid ? baseUrl : 'http://localhost:3002/api';
  }
}