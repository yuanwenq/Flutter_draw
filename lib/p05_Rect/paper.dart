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
  final Paint _paint = Paint();

  PaperPainter() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 画布起点移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2); // 移动原点至(0, 0)
    _drawGrid(canvas, size); // 网格
    _drawAxis(canvas, size); // 中心线
    //
    // _drawRect(canvas);
    // _drawDRRect(canvas);
    _drawFill(canvas);
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

  void _drawAxis(Canvas canvas, Size size) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
    // X轴箭头
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7, size.height / 2 - 10), _paint);
    // Y轴箭头
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _paint);
    // canvas.drawColor(Colors.red, BlendMode.lighten);
  }

  void _drawRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    // 1.矩形中心构造
    Rect rectFromCenter =
        Rect.fromCenter(center: const Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, _paint);
    // 2.矩形左上右下构造
    Rect rectFromLTRB = const Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, _paint..color = Colors.red);
    // 3.矩形左上宽高构造
    Rect rectFromLTWH = const Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, _paint..color = Colors.orange);
    // 4.矩形内切圆构造
    Rect rectFromCircle =
        Rect.fromCircle(center: const Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, _paint..color = Colors.green);
    // 5.矩形两点构造
    Rect rectFromPoints =
        Rect.fromPoints(const Offset(-120, 80), const Offset(-80, 120));
    canvas.drawRect(rectFromPoints, _paint..color = Colors.purple);
  }

  void _drawDRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    Rect outRect =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    Rect inRect =
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);
    canvas.drawDRRect(RRect.fromRectXY(outRect, 20, 20),
        RRect.fromRectXY(inRect, 20, 20), _paint);
  }

  void _drawFill(Canvas canvas) {
    Rect rect =
        Rect.fromCenter(center: const Offset(0, 0), width: 120, height: 100);

    canvas.drawOval(rect, _paint);

    canvas.translate(200, 0);
    canvas.drawArc(rect, 0, pi / 2 * 1, true, _paint);
    canvas.restore();
  }
}
