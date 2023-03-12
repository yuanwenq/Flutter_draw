/*
 * @Date: 2023-03-12
 * @Desc: 
 */
import 'dart:math';

import 'package:flutter/material.dart';

class PicMan extends StatefulWidget {
  final Color color;
  final double angle;
  const PicMan({super.key, this.color = Colors.lightBlue, this.angle = 30});

  @override
  State<PicMan> createState() => _PicManState();
}

class _PicManState extends State<PicMan> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: PicManPainter(color: widget.color, angle: widget.angle),
    );
  }
}

class PicManPainter extends CustomPainter {
  final Color color;
  final double angle;

  Paint _paint = Paint();

  PicManPainter({this.color = Colors.yellowAccent, this.angle = 30});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); // 剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);

    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  @override
  bool shouldRepaint(covariant PicManPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.angle != angle;

  // 绘制头
  void _drawHead(Canvas canvas, Size size) {
    Rect rect = Rect.fromCenter(
        center: const Offset(0, 0), width: size.width, height: size.height);
    var a = angle / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color);
  }

  // 绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }
}
