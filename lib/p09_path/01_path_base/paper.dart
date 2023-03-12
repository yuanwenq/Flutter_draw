/*
 * @Date: 2023-03-08
 * @Desc: 
 */
import 'dart:math';
import 'dart:typed_data';
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
  late Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色
  final List<Offset> points = [
    const Offset(-120, -20),
    const Offset(-80, -80),
    const Offset(-40, -40),
    const Offset(0, -100),
    const Offset(40, -140),
    const Offset(80, -160),
    const Offset(120, -100),
  ];
  final Paint _paint = Paint();
  final Path _gridPath = Path();
  final Coordinate coordinate = Coordinate(step: 25);

  PaperPainter() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 画布起点移到屏幕中心
    // canvas.translate(size.width / 2, size.height / 2); // 移动原点至(0, 0)
    // _drawGrid(canvas, size); // canvas 网格
    // _drawAxis(canvas, size); // 中心线
    // _drawGridLine(canvas, size); // path 坐标
    coordinate.paintBase(canvas, size);
    //
    // 路径移动与画直线
    // _drawPathMoveToAndLineTo(canvas);
    // 相对路径移动与画直线
    // _drawRelativeMoveAndLine(canvas);
    // 圆弧
    // _drawPathArcTo(canvas);
    // _drawPathArcToPoint(canvas);
    // 圆锥曲线
    // _drawRPathConicTo(canvas);
    // 二阶贝塞尔曲线
    // _drawPathQuadraticBezierTo(canvas);
    // 三阶贝塞尔曲线
    // _drawPathCubicTo(canvas);
    // 添加类矩形
    // _drawPathAddRectAndRRect(canvas);
    // 添加类圆形
    // _drawPathOvalAndArc(canvas);
    // 添加多边形，路径
    // _drawPathPolygonAndPath(canvas);
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
  }

  void _drawPathMoveToAndLineTo(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;

    path
      ..moveTo(0, 0) // 移至(0, 0)点
      ..lineTo(60, 80) //从(0,0)画线到(60, 80) 点
      ..lineTo(60, 0) //从(60,80)画线到(60, 0) 点
      ..lineTo(0, -80) //从(60, 0) 画线到(0, -80)点
      ..close(); //闭合路径
    canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path
      ..moveTo(0, 0)
      ..lineTo(-60, 80)
      ..lineTo(-60, 0)
      ..lineTo(0, -80);
    canvas.drawPath(path, paint);
  }

  void _drawRelativeMoveAndLine(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    path
      ..relativeMoveTo(0, 0) // 相对移动到(0, 0)坐标落笔
      ..relativeLineTo(100, 120) // 相对(0, 0)画直线至(100, 120)
      ..relativeLineTo(-10, -60) // 相对(100, 120)画直线至(-10, -60)
      ..relativeLineTo(
        60,
        -10,
      ) // 相对(-10, -60)画直线至(60, -10)
      ..close(); // 闭合路径
    canvas.drawPath(path, paint);

    path.reset();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 2;
    path
      ..relativeMoveTo(-200, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(
        60,
        -10,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawPathArcTo(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

// 绘制左侧
    var rect = Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);
    path.lineTo(30, 30);
    path.arcTo(rect, 0, pi * 1.5, true);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(200, 0);
// 绘制右侧
    path.lineTo(30, 30);
    path.arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);
  }

  // 画圆弧到某个点
  void _drawPathArcToPoint(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.lineTo(80, -40);

    //绘制中间
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: false,
      )
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(-150, 0);
    //绘制左侧
    path.lineTo(80, -40);
    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(150 + 150.0, 0);
    //绘制右侧
    path.lineTo(80, -40);
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: true,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  // 圆锥曲线
  void _drawRPathConicTo(Canvas canvas) {
    final Offset p1 = Offset(80, -100);
    final Offset p2 = Offset(160, 0);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

//抛物线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(-180, 0);
//椭圆线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(180 + 180.0, 0);
//双曲线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.5);
    canvas.drawPath(path, paint);
  }

  // 二阶贝塞尔曲线
  void _drawPathQuadraticBezierTo(Canvas canvas) {
    final Offset p1 = Offset(100, -100);
    final Offset p2 = Offset(160, 50);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    path.relativeQuadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);
  }

  // 三阶贝塞尔曲线
  void _drawPathCubicTo(Canvas canvas) {
    final Offset p1 = Offset(100, -100);
    final Offset p2 = Offset(160, 50);
    final Offset p3 = Offset(180, 0);

    Path path = Path();
    Paint paint = Paint();
    paint
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);

    path.relativeCubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    canvas.drawPath(path, paint);
  }

  // 添加路径矩形
  void _drawPathAddRectAndRRect(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromPoints(Offset(100, 100), Offset(160, 160));
    path
      ..lineTo(100, 100)
      ..addRect(rect)
      ..relativeLineTo(100, -100)
      ..addRRect(RRect.fromRectXY(rect.translate(100, -100), 10, 10));
    canvas.drawPath(path, paint);
  }

  // 添加类圆形
  void _drawPathOvalAndArc(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromPoints(Offset(100, 100), Offset(160, 140));
    path
      ..lineTo(100, 100)
      ..addOval(rect)
      ..relativeLineTo(100, -100)
      ..addArc(rect.translate(100 + 60.0, -100), 0, pi);
    canvas.drawPath(path, paint);
  }

  // 添加多边形路径 、addPath：添加路径
  void _drawPathPolygonAndPath(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    var p0 = Offset(100, 100);
    path
      ..lineTo(100, 100)
      ..addPolygon([
        p0,
        p0.translate(20, -20),
        p0.translate(40, -20),
        p0.translate(60, 0),
        p0.translate(60, 20),
        p0.translate(40, 40),
        p0.translate(20, 40),
        p0.translate(0, 20),
      ], true)
      ..addPath(
          Path()..relativeQuadraticBezierTo(125, -100, 260, 0), Offset.zero)
      ..lineTo(160, 100);
    canvas.drawPath(path, paint);
  }

  void _drawGridLine(Canvas canvas, Size size) {
    _gridPint
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = Colors.grey;

    for (int i = 0; i < size.width / 2 / step; i++) {
      _gridPath.moveTo(step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
      _gridPath.moveTo(-step * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      _gridPath.moveTo(-size.width / 2, step * i);
      _gridPath.relativeLineTo(size.width, 0);
      _gridPath.moveTo(
        -size.width / 2,
        -step * i,
      );
      _gridPath.relativeLineTo(size.width, 0);
    }
    canvas.drawPath(_gridPath, _gridPint);
  }
}
