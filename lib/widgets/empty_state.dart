import 'package:flutter/material.dart';
import 'package:knot/utils/app_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: _NotebookIllustrationPainter(),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Nothing here yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tap the + button below to\ntie your first thought',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}


class _NotebookIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final shadowPaint = Paint()
      ..color = const Color(0xFF0D1B3E).withOpacity(0.08)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.18, w * 0.72, h * 0.72),
        Radius.circular(16),
      ),
      shadowPaint,
    );

    final bodyPaint = Paint()..color = const Color(0xFFF5F0E8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.12, w * 0.70, h * 0.70),
        Radius.circular(12),
      ),
      bodyPaint,
    );

    final spinePaint = Paint()..color = const Color(0xFF0D1B3E);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.12, w * 0.10, h * 0.70),
        Radius.circular(8),
      ),
      spinePaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFF0D1B3E).withOpacity(0.12)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final lineStartX = w * 0.33;
    final lineEndX = w * 0.78;
    for (int i = 0; i < 5; i++) {
      final y = h * 0.30 + i * h * 0.10;
      canvas.drawLine(Offset(lineStartX, y), Offset(lineEndX, y), linePaint);
    }

    canvas.drawLine(
      Offset(lineStartX, h * 0.30 + 5 * h * 0.10),
      Offset(lineStartX + (lineEndX - lineStartX) * 0.5, h * 0.30 + 5 * h * 0.10),
      linePaint,
    );

    final knotPaint = Paint()
      ..color = const Color(0xFFC9A84C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final knotPath = Path();
    final cx = w * 0.72;
    final cy = h * 0.78;
    knotPath.moveTo(cx - 18, cy - 10);
    knotPath.cubicTo(cx - 10, cy - 28, cx + 18, cy - 24, cx + 14, cy - 8);
    knotPath.cubicTo(cx + 10, cy + 8, cx - 14, cy + 4, cx - 8, cy + 18);
    knotPath.cubicTo(cx, cy + 28, cx + 18, cy + 20, cx + 20, cy + 6);

    canvas.drawPath(knotPath, knotPaint);

    final plusPaint = Paint()
      ..color = const Color(0xFF0D1B3E).withOpacity(0.18)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final px = w * 0.555;
    final py = h * 0.72;
    canvas.drawLine(Offset(px - 10, py), Offset(px + 10, py), plusPaint);
    canvas.drawLine(Offset(px, py - 10), Offset(px, py + 10), plusPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


