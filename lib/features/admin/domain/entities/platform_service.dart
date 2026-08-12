import 'package:flutter/foundation.dart';

/// Platform Service & Product Entity for MASARI Operations Management
@immutable
class PlatformService {
  final String id;
  final String name;
  final String category; // 'Umrah', 'Hajj', 'Flight', 'Hotel', 'Bus', 'Car', 'Transfer', 'Tourism'
  final String description;
  final double price;
  final String currency;
  final bool isActive;
  final String imageUrl;

  const PlatformService({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    this.currency = 'SAR',
    this.isActive = true,
    required this.imageUrl,
  });

  PlatformService copyWith({
    String? name,
    String? category,
    String? description,
    double? price,
    String? currency,
    bool? isActive,
    String? imageUrl,
  }) {
    return PlatformService(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
