import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../domain/entities/platform_service.dart';
import '../providers/platform_services_persistence_provider.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_section_header.dart';

/// Customer-facing catalog view backed by the same operational state used by
/// the admin portal, including persisted administrator changes.
class _TravelServiceCatalogView extends ConsumerWidget {
  final String title;
  final String routePath;
