import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';

/// User Avatar Component
class MasariAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final double radius;

  const MasariAvatar({
    super.key,
    this.imageUrl,
    this.initials = 'م',
    this.radius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: MasariColors.royalGold,
      child: Text(
        initials,
        style: TextStyle(
          color: MasariColors.deepBlue,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.9,
        ),
      ),
    );
  }
}

/// Status / Feature Badge Component
class MasariBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const MasariBadge({
    super.key,
    required this.label,
    this.backgroundColor = MasariColors.royalGold,
    this.textColor = MasariColors.deepBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// Category Selectable Chip Component
class MasariChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const MasariChip({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? MasariColors.deepBlue : MasariColors.pureWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? MasariColors.royalGold : MasariColors.titaniumDivider,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: isSelected ? MasariColors.royalGold : MasariColors.titaniumGray),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: MasariTypography.bodySmall(
                color: isSelected ? MasariColors.pureWhite : MasariColors.darkGraphite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sidebar / Navigation Item Component
class MasariNavigationItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const MasariNavigationItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? MasariColors.royalGold : MasariColors.titaniumLight,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? MasariColors.pureWhite : MasariColors.titaniumLight,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: MasariColors.deepBlueLight.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
    );
  }
}
