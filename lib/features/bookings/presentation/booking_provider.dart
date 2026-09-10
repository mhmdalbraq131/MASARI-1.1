import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/booking_record.dart';
import '../../foundation/presentation/providers/app_providers.dart';

class BookingNotifier extends StateNotifier<List<BookingRecord>> {
  BookingNotifier(this.ref) : super(const []) {
    _load();
  }

  final Ref ref;
  static const _key = 'masari.bookings.v1';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return;
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      state = decoded.map((item) => BookingRecord.fromJson(Map<String, dynamic>.from(item as Map))).toList();
    } catch (_) {
      state = const [];
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(state.map((item) => item.toJson()).toList()));
  }

  Future<void> createBooking({required String serviceId, required String serviceName, required String category, required double price, required String currency}) async {
    final session = ref.read(userSessionProvider);
    final booking = BookingRecord(
      id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
      serviceId: serviceId,
      serviceName: serviceName,
      category: category,
      price: price,
      currency: currency,
      customerName: session.name,
      customerEmail: session.email,
      status: 'قيد الطلب',
      createdAt: DateTime.now(),
    );
    state = [booking, ...state];
    await _save();
  }

  Future<void> updateStatus(String bookingId, String status) async {
    state = [for (final item in state) item.id == bookingId ? item.copyWith(status: status) : item];
    await _save();
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, List<BookingRecord>>((ref) => BookingNotifier(ref));
