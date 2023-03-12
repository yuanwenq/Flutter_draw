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
      ..color = Colors.purple
      ..style = PaintingStyle.fill;
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    canvas.drawPath(path, paint);

    print(path.contains(const Offset(20, 20)));
    print(path.contains(const Offset(0, 20)));

    Rect bounds = path.getBounds();
    print(bounds.toString());
    canvas.drawRect(
        bounds,
        paint
          ..color = Colors.orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
