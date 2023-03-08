/*
 * @Date: 2023-03-08
 * @Desc: 
 */
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
  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔
    // final Paint paint = Paint();

    // paint
    //   ..color = Colors.blue // 颜色
    //   ..strokeWidth = 4 // 线宽
    //   ..style = PaintingStyle.stroke; // 模式--线型

    // // // 绘制圆
    // canvas.drawCircle(Offset(100, 100), 10, paint); // 绘制圆
    // canvas.drawLine(Offset(0, 0), Offset(100, 100), paint); // 绘制线

    // Path path = Path();
    // path.moveTo(100, 100);
    // path.lineTo(200, 0);
    // canvas.drawPath(path, paint..color = Colors.red);

    // drawIsAntiAliasColor(canvas);
    // drawStyleStrokeWidth(canvas);
    // drawStrokeCap(canvas);
    // drawStrokeJoin(canvas);
    drawStrokeMiterLimit(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 画笔 抗锯齿 与 非抗锯齿的区别
void drawIsAntiAliasColor(Canvas canvas) {
  Paint paint = Paint();

  canvas.drawCircle(
      Offset(180, 180),
      170,
      paint
        ..color = Colors.blue
        ..strokeWidth = 5);
  canvas.drawCircle(
      Offset(180 + 360, 180),
      170,
      paint
        ..isAntiAlias = false
        ..color = Colors.red);
}

void drawStyleStrokeWidth(Canvas canvas) {
  Paint paint = Paint()..color = Colors.red;

  canvas.drawCircle(
      const Offset(180, 180),
      150,
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 50);
  canvas.drawCircle(
      const Offset(180 + 360, 180),
      150,
      paint
        ..strokeWidth = 50
        ..style = PaintingStyle.fill);
}

void drawStrokeCap(Canvas canvas) {
  Paint paint = Paint();
  paint
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..strokeWidth = 20;

  canvas.drawLine(const Offset(50, 50), const Offset(50, 150),
      paint..strokeCap = StrokeCap.butt);
  canvas.drawLine(const Offset(50 + 50, 50), const Offset(50 + 50, 150),
      paint..strokeCap = StrokeCap.round);
  canvas.drawLine(const Offset(50 + 50 * 2, 50), const Offset(50 + 50 * 2, 150),
      paint..strokeCap = StrokeCap.square);
}

void drawStrokeJoin(Canvas canvas) {
  Paint paint = Paint();
  Path path = Path();

  paint
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..strokeWidth = 20;

  path.moveTo(50, 50);
  path.lineTo(50, 150);
  path.relativeLineTo(100, -50);
  path.relativeLineTo(0, 100);
  canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

  path.reset();
  path.moveTo(50 + 150.0, 50);
  path.lineTo(50 + 150.0, 150);
  path.relativeLineTo(100, -50);
  path.relativeLineTo(0, 100);
  canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

  path.reset();
  path.moveTo(50 + 150.0 * 2, 50);
  path.lineTo(50 + 150.0 * 2, 150);
  path.relativeLineTo(100, -50);
  path.relativeLineTo(0, 100);
  canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
}

void drawStrokeMiterLimit(Canvas canvas) {
  Paint paint = Paint();
  Path path = Path();
  paint
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..strokeJoin = StrokeJoin.miter
    // ..blendMode = BlendMode.color
    ..strokeWidth = 20;
  for (int i = 0; i < 4; i++) {
    path.reset();
    path.moveTo(50 + 150.0 * i, 50);
    path.lineTo(50 + 150.0 * i, 150);
    path.relativeLineTo(100, -(40.0 * i + 20));
    canvas.drawPath(path, paint..strokeMiterLimit = 2);
  }
  for (int i = 0; i < 4; i++) {
    path.reset();
    path.moveTo(50 + 150.0 * i, 50 + 150.0);
    path.lineTo(50 + 150.0 * i, 150 + 150.0);
    path.relativeLineTo(100, -(40.0 * i + 20));
    canvas.drawPath(path, paint..strokeMiterLimit = 3);
  }
}
