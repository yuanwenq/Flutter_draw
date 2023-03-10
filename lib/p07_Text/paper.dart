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
  final double step = 25; // 小格边长
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
    // _drawImageNine(canvas);
    // _drawTextWithParagraph(canvas, TextAlign.left);
    _drawTextPaint(canvas);
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

  void _drawTextWithParagraph(Canvas canvas, TextAlign textAlign) {
    // 段落构造器
    ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: textAlign,
        fontSize: 40,
        textDirection: TextDirection.ltr,
        maxLines: 1));
    // 段落中的文字样式设置
    builder.pushStyle(ui.TextStyle(
        color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic));
    // 文字内容
    builder.addText("Flutter Unit");
    // 段落构建
    ui.Paragraph paragraph = builder.build();
    // 段落容器约束，进行布局
    paragraph.layout(const ui.ParagraphConstraints(width: 300));
    // 画布绘制
    canvas.drawParagraph(paragraph, const Offset(0, 0));
    canvas.drawRect(const Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaint(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: "Flutter Unit by 张老六流流",
          style: TextStyle(fontSize: 40, foreground: textPaint),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: 280); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }
}
