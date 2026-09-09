import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/config/firebase_config.dart';
import 'features/foundation/data/repositories/platform_service_persistence.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize MASARI Application Environment Configuration
  AppConfig.initialize(environment: Environment.dev);

  // Initialize Firebase Foundation Architecture
  await FirebaseConfig.initializeFirebase();

  // Load persisted operational catalog before the first frame so administrator
  // changes are immediately reflected across customer and admin views.
  await PlatformServicePersistence.initialize();

  runApp(
    const ProviderScope(
      child: MasariApp(),
    ),
  );
}
