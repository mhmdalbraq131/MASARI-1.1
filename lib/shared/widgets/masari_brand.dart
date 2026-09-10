import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';

/// Reusable MASARI brand lockup used by the application shell.
///
/// The mark intentionally stays vector-based so the identity remains crisp on
/// mobile, desktop, Windows and Web without requiring an external logo package.
class MasariBrand extends StatelessWidget {
  const MasariBrand({
    super.key,
    this.compact = false,
    this.onTap,
  });

  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = compact
        ? const _MasariMark(size: 38)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _MasariMark(size: 42),
              SizedBox(width: 10),
              _MasariBrandText(),
            ],
          );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: content,
      ),
    );
  }
}

class _MasariBrandText extends StatelessWidget {
  const _MasariBrandText();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.appNameArabic,
          style: MasariTypography.titleMedium(
            color: MasariColors.brandBlue,
            isArabic: true,
          ),
        ),
        Text(
          'وكالة مساري',
          style: MasariTypography.caption(
            color: MasariColors.brandBlue,
            isArabic: true,
          ),
        ),
      ],
    );
  }
}

class _MasariMark extends StatelessWidget {
  const _MasariMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _MasariMarkPainter(),
      ),
    );
  }
}

class _MasariMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 42;

    final blue = Paint()
      ..color = MasariColors.brandBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.2 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cyan = Paint()
      ..color = MasariColors.brandTurquoise
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final orange = Paint()
      ..color = MasariColors.brandOrange
      ..style = PaintingStyle.fill;

    final left = Path()
      ..moveTo(9 * scale, 31 * scale)
      ..lineTo(9 * scale, 17 * scale)
      ..cubicTo(9 * scale, 11 * scale, 14 * scale, 8 * scale, 19 * scale, 9 * scale)
      ..cubicTo(24 * scale, 10 * scale, 25 * scale, 15 * scale, 25 * scale, 19 * scale);
    canvas.drawPath(left, blue);

    final right = Path()
      ..moveTo(19 * scale, 31 * scale)
      ..cubicTo(19 * scale, 24 * scale, 23 * scale, 20 * scale, 29 * scale, 20 * scale)
      ..cubicTo(33 * scale, 20 * scale, 35 * scale, 22 * scale, 35 * scale, 25 * scale);
    canvas.drawPath(right, cyan);

    final plane = Path()
      ..moveTo(28 * scale, 13 * scale)
      ..lineTo(38 * scale, 8 * scale)
      ..lineTo(34 * scale, 17 * scale)
      ..lineTo(31 * scale, 14 * scale)
      ..close();
    canvas.drawPath(plane, orange);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
