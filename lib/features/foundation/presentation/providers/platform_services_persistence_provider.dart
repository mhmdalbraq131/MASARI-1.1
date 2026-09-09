import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/platform_service_persistence.dart';
import '../../domain/entities/platform_service.dart';
import 'app_providers.dart';

/// Applies persisted administrator changes to the operational catalog shown
/// throughout the app while keeping the existing platform service provider
/// intact for backwards compatibility.
final operationalPlatformServicesProvider = Provider<List<PlatformService>>((ref) {
  final services = ref.watch(platformServicesProvider);
  return services.map(PlatformServicePersistence.apply).toList(growable: false);
});

/// Activates persistence for every administrator change to the service catalog.
final platformServicesPersistenceSyncProvider = Provider<void>((ref) {
  ref.listen<List<PlatformService>>(
    platformServicesProvider,
    (_, next) {
      PlatformServicePersistence.save(next);
    },
    fireImmediately: true,
  );
});
