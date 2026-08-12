import 'package:flutter/foundation.dart';

/// MASARI Security & Compliance Audit Logger.
/// Tracks sensitive security actions, route transitions, role escalations, and system events.
class AuditLogger {
  static void logEvent({
    required String eventName,
    required String actorId,
    Map<String, dynamic>? metadata,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    debugPrint('[AUDIT LOG $timestamp] Event: $eventName | Actor: $actorId | Meta: $metadata');
  }
}
