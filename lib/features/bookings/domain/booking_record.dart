import 'package:flutter/foundation.dart';

@immutable
class BookingRecord {
  final String id;
  final String serviceId;
  final String serviceName;
  final String category;
  final double price;
  final String currency;
  final String customerName;
  final String customerEmail;
  final String status;
  final DateTime createdAt;

  const BookingRecord({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.category,
    required this.price,
    required this.currency,
    required this.customerName,
    required this.customerEmail,
    required this.status,
    required this.createdAt,
  });

  BookingRecord copyWith({String? status}) => BookingRecord(
        id: id,
        serviceId: serviceId,
        serviceName: serviceName,
        category: category,
        price: price,
        currency: currency,
        customerName: customerName,
        customerEmail: customerEmail,
        status: status ?? this.status,
        createdAt: createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'serviceId': serviceId,
        'serviceName': serviceName,
        'category': category,
        'price': price,
        'currency': currency,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };

  factory BookingRecord.fromJson(Map<String, dynamic> json) => BookingRecord(
        id: json['id'] as String,
        serviceId: json['serviceId'] as String,
        serviceName: json['serviceName'] as String,
        category: json['category'] as String,
        price: (json['price'] as num).toDouble(),
        currency: json['currency'] as String? ?? 'SAR',
        customerName: json['customerName'] as String? ?? 'زائر',
        customerEmail: json['customerEmail'] as String? ?? '',
        status: json['status'] as String? ?? 'قيد الطلب',
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
