/*
 * @Date: 2023-03-08
 * @Desc: 
 */
import 'dart:math';

import 'package:flutter/material.dart';

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
  late Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色

  PaperPainter() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    // 画布起点移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);

    canvas.drawCircle(const Offset(0, 0), 50, paint);
    canvas.drawLine(
        const Offset(20, 20),
        const Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    _drawDot(canvas, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  // 网格线，画笔移动还是画布移动？
  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (var i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(const Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (var i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(
          const Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1); // x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); // y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); // 原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawDot(Canvas canvas, Paint paint) {
    const int count = 12;
    paint
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke;

    canvas.save();
    for (var i = 0; i < count; i++) {
      var step = 2 * pi / count;
      canvas.drawLine(const Offset(80, 0), const Offset(100, 0), paint);
      canvas.rotate(step);
    }
    canvas.restore();
  }
}
