/*
 * @Date: 2023-03-08
 * @Desc: 
 */

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets("assets/images/414x358.png");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_image),
      ),
    );
  }

  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data =
        await rootBundle.load(path); // 将 assets 的文件读取为字节流可以使用 rootBundle 方法
    return decodeImageFromList(data.buffer
        .asUint8List()); // 通过 decodeImageFromList 可以将一个字节流转为 ui.Image 对象
  }
}

class PaperPainter extends CustomPainter {
  late Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色
  final Paint _paint = Paint();

  final ui.Image? image;

  PaperPainter(this.image) {
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
    // _drawImage(canvas);
    // _drawImageRect(canvas);
    _drawImageNine(canvas);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;

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

  void _drawImage(Canvas canvas) {
    if (image != null) {
      canvas.drawImage(
          image!, Offset(-image!.width / 2, -image!.height / 2), _paint);
    }
  }

  void _drawImageRect(Canvas canvas) {
    if (image != null) {
      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height / 2),
              width: 60,
              height: 60),
          const Rect.fromLTRB(0, 0, 100, 100),
          _paint);

      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height / 2 - 60),
              width: 60,
              height: 60),
          const Rect.fromLTRB(0, 0, 100, 100).translate(-280, -100),
          _paint);

      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2 + 60, image!.height / 2),
              width: 60,
              height: 60),
          const Rect.fromLTRB(0, 0, 100, 100).translate(-280, 50),
          _paint);
    }
  }

  void _drawImageNine(Canvas canvas) {
    if (image != null) {
      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6),
              width: image!.width - 20,
              height: 2),
          Rect.fromCenter(center: const Offset(0, 0), width: 300, height: 120),
          _paint);

      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6),
              width: image!.width - 20,
              height: 2),
          Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 50)
              .translate(250, 0),
          _paint);

      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height / 2),
              width: image!.width - 20,
              height: 2),
          Rect.fromCenter(center: Offset(0, 0), width: 80, height: 250)
              .translate(-250, 0),
          _paint);
    }
  }
}
