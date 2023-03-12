/*
 * @Date: 2023-03-12
 * @Desc: 
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_draw/p10_anim/03_animate_tween/color_double_tween.dart';

class PicMan extends StatefulWidget {
  final Color color;

  const PicMan({super.key, this.color = Colors.lightBlue});

  @override
  State<PicMan> createState() => _PicManState();
}

class _PicManState extends State<PicMan> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 下面的 _controller 会在两秒之内将数值从 10 连续变化到 40
    // 控制器使用 Ticker 节拍器在给定的时间内不停的执行数值的变化 10 -> 40, 40 -> 10
    _controller = AnimationController(
        duration: const Duration(seconds: 1), // 运动时长
        vsync: this);

    // 重复执行动画
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: PicManPainter(_controller),
    );
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> repaint;
  final Paint _paint = Paint();

  final ColorDoubleTween tween = ColorDoubleTween(
      begin: ColorDouble(color: Colors.purple, value: 10),
      end: ColorDouble(color: Colors.green, value: 40));

  PicManPainter(this.repaint)
      : super(repaint: repaint); // <----- 传入 Listenable 可监听对象

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
      oldDelegate.repaint != repaint;

  // 绘制头
  void _drawHead(Canvas canvas, Size size) {
    Rect rect = Rect.fromCenter(
        center: const Offset(0, 0), width: size.width, height: size.height);
    var a = tween.evaluate(repaint).value / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true,
        _paint..color = tween.evaluate(repaint).color ?? Colors.black);
  }

  // 绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }
}
