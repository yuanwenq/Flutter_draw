/*
 * @Date: 2023-03-08
 * @Desc: 
 */

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
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path
      ..lineTo(100, 100)
      ..relativeLineTo(0, -50)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path.shift(const Offset(100, 0)), paint);
    canvas.drawPath(path.shift(const Offset(200, 0)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
