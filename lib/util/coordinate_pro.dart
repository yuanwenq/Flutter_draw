/*
 * @Date: 2023-03-12
 * @Desc: 
 */
/*
 * @Date: 2023-03-11
 * @Desc: 
 */
import 'package:flutter/material.dart';

class Coordinate {
  final double step;
  final Paint _linePaint = Paint();
  final Paint _gridPaint = Paint();
  final Path _gridPath = Path();
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  Coordinate({required this.step});

  void paintBase(Canvas canvas, Size size) {
    canvas.save();
    // 画布起点移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2); // 移动原点至(0, 0)

    _drawGrid(canvas, size);
    _drawCenterLine(canvas, size);
    _drawTextCoordinate(canvas, size);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    // 网格
    _gridPaint
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
    canvas.drawPath(_gridPath, _gridPaint);
  }

  void _drawCenterLine(Canvas canvas, Size size) {
    // 中心十字线
    _linePaint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _linePaint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _linePaint);
    // X轴箭头
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7, size.height / 2 - 10), _linePaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7, size.height / 2 - 10), _linePaint);
    // Y轴箭头
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _linePaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _linePaint);
  }

  void _drawTextCoordinate(Canvas canvas, Size size) {
    // y > 0 轴 文字
    canvas.save();
    for (var i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        String str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green);
      }
      canvas.translate(0, step);
    }
    canvas.restore();
    // x > 0 轴 文字
    canvas.save();
    for (var i = 0; i < size.width / 2 / step; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "0", color: Colors.black, x: null);
        canvas.translate(step, 0);
        continue;
      }
      if (step < 30 && i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        String str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, x: true);
      }
      canvas.translate(step, 0);
    }
    canvas.restore();
    // y < 0 轴文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green);
      }
      canvas.translate(0, -step);
    }
    canvas.restore();
    // x < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: true);
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.green, bool? x = false}) {
    TextSpan text =
        TextSpan(text: str, style: TextStyle(fontSize: 11, color: color));
    _textPainter.text = text;
    _textPainter.layout(); // 进行布局

    Size size = _textPainter.size;
    Offset offset = Offset.zero;
    if (x == null) {
      offset = const Offset(8, 8);
    } else if (x) {
      offset = Offset(-size.width / 2, size.height / 2);
    } else {
      offset = Offset(size.width / 2, -size.height / 2 + 2);
    }
    _textPainter.paint(canvas, offset);
  }
}
