import 'package:flutter/foundation.dart';

/// Platform Service & Product Domain Entity for MASARI Operations
@immutable
class PlatformService {
  final String id;
  final String category; // e.g., 'عمرة', 'حج', 'طيران', 'فنادق', 'حافلات', 'سيارات', 'سياحة'
  final String name;
  final String description;
  final double price;
  final String currency;
  final String status; // 'نشط', 'معطل'
  final String imageUrl;
  final Map<String, String> metadata;

  const PlatformService({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    this.currency = 'SAR',
    required this.status,
    required this.imageUrl,
    this.metadata = const {},
  });

  PlatformService copyWith({
    String? id,
    String? category,
    String? name,
    String? description,
    double? price,
    String? currency,
    String? status,
    String? imageUrl,
    Map<String, String>? metadata,
  }) {
    return PlatformService(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      metadata: metadata ?? this.metadata,
    );
  }
}
