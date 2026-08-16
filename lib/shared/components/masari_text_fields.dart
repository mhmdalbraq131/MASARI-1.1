import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_spacing.dart';
import '../../core/theme/masari_typography.dart';

/// Primary MASARI Input Field
class MasariTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;

  const MasariTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? MasariColors.pureWhite : MasariColors.darkGraphite;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: MasariTypography.titleSmall(color: labelColor),
        ),
        const SizedBox(height: MasariSpacing.xs),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: MasariColors.titaniumGray, size: 20) : null,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

/// Password Input Field with Toggle Visibility
class MasariPasswordField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const MasariPasswordField({
    super.key,
    this.label = 'كلمة المرور',
    this.controller,
  });

  @override
  State<MasariPasswordField> createState() => _MasariPasswordFieldState();
}

class _MasariPasswordFieldState extends State<MasariPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MasariTextField(
      label: widget.label,
      controller: widget.controller,
      prefixIcon: Icons.lock_outline,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: MasariColors.titaniumGray),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}

/// Travel Search Field
class MasariSearchField extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;

  const MasariSearchField({
    super.key,
    this.hint = 'ابحث عن الوجهات، الرحلات، أو الفنادق...',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillBg = isDark ? MasariColors.graphiteSurface : MasariColors.pureWhite;
    final borderColor = isDark ? MasariColors.primaryCyan.withValues(alpha: 0.2) : MasariColors.titaniumDivider;

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: MasariTypography.bodyMedium(color: MasariColors.titaniumGray),
        prefixIcon: const Icon(Icons.search, color: MasariColors.primaryCyan),
        fillColor: fillBg,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: MasariSpacing.borderLg,
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderLg,
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderLg,
          borderSide: const BorderSide(color: MasariColors.primaryCyan, width: 1.5),
        ),
      ),
    );
  }
}
