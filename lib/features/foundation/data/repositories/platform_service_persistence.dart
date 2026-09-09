import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/platform_service.dart';

/// Local persistence for the operational service catalog.
///
/// The provider remains the single in-memory source of truth while this store
/// keeps administrator changes across application restarts. This is a local
/// foundation layer; it can later be replaced by Firestore/API persistence
/// without changing the presentation layer.
class PlatformServicePersistence {
  PlatformServicePersistence._();

  static const String _key = 'masari.platform_services.v1';
  static SharedPreferences? _preferences;
  static Map<String, Map<String, dynamic>> _overrides = {};

  static Future<void> initialize() async {
    _preferences ??= await SharedPreferences.getInstance();
    final raw = _preferences!.getString(_key);
    if (raw == null || raw.isEmpty) return;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        _overrides = decoded.map(
          (key, value) => MapEntry(
            key,
            value is Map
                ? Map<String, dynamic>.from(value)
                : <String, dynamic>{},
          ),
        );
      }
    } catch (_) {
      _overrides = {};
    }
  }

  static PlatformService apply(PlatformService service) {
    final override = _overrides[service.id];
    if (override == null) return service;

    return service.copyWith(
      name: override['name'] as String?,
      description: override['description'] as String?,
      price: (override['price'] as num?)?.toDouble(),
      status: override['status'] as String?,
    );
  }

  static Future<void> save(List<PlatformService> services) async {
    _preferences ??= await SharedPreferences.getInstance();

    for (final service in services) {
      _overrides[service.id] = {
        'name': service.name,
        'description': service.description,
        'price': service.price,
        'status': service.status,
      };
    }

    await _preferences!.setString(_key, jsonEncode(_overrides));
  }
}
