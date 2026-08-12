import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/config/firebase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize MASARI Application Environment Configuration
  AppConfig.initialize(environment: Environment.dev);

  // Initialize Firebase Foundation Architecture
  await FirebaseConfig.initializeFirebase();

  runApp(
    const ProviderScope(
      child: MasariApp(),
    ),
  );
}
