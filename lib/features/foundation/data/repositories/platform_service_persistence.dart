import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/platform_service.dart';

class PlatformServicePersistence {
  PlatformServicePersistence._();

  static const String _key = 'masari.platform_services.v1';
  static SharedPreferences? _preferences;
  static List<PlatformService>? _catalog;
  static Map<String, Map<String, dynamic>> _legacyOverrides = {};

  static Future<void> initialize() async {
    _preferences ??= await SharedPreferences.getInstance();
    final raw = _preferences!.getString(_key);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        _catalog = decoded.whereType<Map>().map((item) => _fromJson(Map<String, dynamic>.from(item))).toList();
      } else if (decoded is Map<String, dynamic>) {
        _legacyOverrides = decoded.map((key, value) => MapEntry(key, value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{}));
      }
    } catch (_) {
      _catalog = null;
      _legacyOverrides = {};
    }
  }

  static List<PlatformService> loadCatalog(List<PlatformService> defaults) {
    final result = <PlatformService>[];
    final storedById = <String, PlatformService>{for (final service in (_catalog ?? const <PlatformService>[])) service.id: service};
    for (final service in defaults) {
      var resolved = storedById.remove(service.id) ?? service;
      final legacy = _legacyOverrides[service.id];
      if (legacy != null) resolved = _applyLegacy(resolved, legacy);
      result.add(resolved);
    }
    result.addAll(storedById.values);
    return result;
  }

  static PlatformService apply(PlatformService service) {
    PlatformService? stored;
    for (final item in (_catalog ?? const <PlatformService>[])) {
      if (item.id == service.id) {
        stored = item;
        break;
      }
    }
    if (stored != null) return stored;
    final legacy = _legacyOverrides[service.id];
    return legacy == null ? service : _applyLegacy(service, legacy);
  }

  static Future<void> save(List<PlatformService> services) => saveCatalog(services);

  static Future<void> saveCatalog(List<PlatformService> services) async {
    _preferences ??= await SharedPreferences.getInstance();
    _catalog = List<PlatformService>.from(services);
    _legacyOverrides = {};
    await _preferences!.setString(_key, jsonEncode(services.map(_toJson).toList()));
  }

  static Map<String, dynamic> _toJson(PlatformService service) => {
        'id': service.id,
        'category': service.category,
        'name': service.name,
        'description': service.description,
        'price': service.price,
        'currency': service.currency,
        'status': service.status,
        'imageUrl': service.imageUrl,
        'metadata': service.metadata,
      };

  static PlatformService _fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'];
    return PlatformService(
      id: json['id'] as String,
      category: json['category'] as String? ?? 'أخرى',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? 'SAR',
      status: json['status'] as String? ?? 'نشط',
      imageUrl: json['imageUrl'] as String? ?? '',
      metadata: metadata is Map ? metadata.map((key, value) => MapEntry(key.toString(), value.toString())) : const {},
    );
  }

  static PlatformService _applyLegacy(PlatformService service, Map<String, dynamic> override) => service.copyWith(
        name: override['name'] as String?,
        description: override['description'] as String?,
        price: (override['price'] as num?)?.toDouble(),
        status: override['status'] as String?,
        imageUrl: override['imageUrl'] as String?,
        metadata: override['metadata'] is Map ? (override['metadata'] as Map).map((key, value) => MapEntry(key.toString(), value.toString())) : null,
      );
}
