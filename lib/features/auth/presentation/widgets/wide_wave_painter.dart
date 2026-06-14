import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class WideWavePainter extends CustomPainter {
  final Animation<double> waveAnimation;
  final Color color;
  final double wavePhase;
  final double waveHeight;
  final double frequency;

  WideWavePainter({
    required this.waveAnimation,
    required this.color,
    required this.wavePhase,
    required this.waveHeight,
    required this.frequency,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path();

    final midHeight = size.height * 0.5;

    path.moveTo(0, midHeight);

    for (double x = 0; x <= size.width; x++) {
      final double y =
      midHeight +
          math.sin(
                (x / size.width * frequency * math.pi) +
                    (waveAnimation.value * 2 * math.pi) +
                    wavePhase,
              ) *
              waveHeight;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
