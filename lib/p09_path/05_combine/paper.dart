/*
 * @Date: 2023-03-08
 * @Desc: 
 */

import 'dart:math';

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
      ..style = PaintingStyle.fill;
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    var pathOval = Path()
      ..addOval(
          Rect.fromCenter(center: const Offset(0, 0), width: 60, height: 60));
    canvas.drawPath(
        Path.combine(PathOperation.difference, path, pathOval), paint);

    canvas.translate(120, 0);
    canvas.drawPath(
        Path.combine(PathOperation.intersect, path, pathOval), paint);

    canvas.translate(120, 0);
    canvas.drawPath(Path.combine(PathOperation.union, path, pathOval), paint);

    canvas.translate(-120 * 3, 0);
    canvas.drawPath(
        Path.combine(PathOperation.reverseDifference, path, pathOval), paint);

    canvas.translate(-120, 0);
    canvas.drawPath(Path.combine(PathOperation.xor, path, pathOval), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
