/*
 * @Date: 2023-03-08
 * @Desc: 
 */

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_draw/util/coordinate.dart';

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色
  final Coordinate coordinate = Coordinate(step: 25);

  PaperPainter();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paintBase(canvas, size);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      print(
          "---length:-${pm.length}----contourIndex:-${pm.contourIndex}----contourIndex:-${pm.isClosed}----");

      Tangent? tangent = pm.getTangentForOffset(pm.length * 0.5);
      if (tangent == null) return;
      print(
          "---position:-${tangent.position}----angle:-${tangent.angle}----vector:-${tangent.vector}----");

      canvas.drawCircle(
          tangent.position, 5, Paint()..color = Colors.deepOrange);
    });

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
