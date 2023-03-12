/*
 * @Date: 2023-03-12
 * @Desc: 
 */
import 'package:flutter/material.dart';

class ColorDouble {
  final Color? color;
  final double value;

  ColorDouble({this.color = Colors.blue, this.value = 0});
}

class ColorDoubleTween extends Tween<ColorDouble> {
  ColorDoubleTween({required ColorDouble begin, required ColorDouble end})
      : super(begin: begin, end: end);

  @override
  ColorDouble lerp(double t) => ColorDouble(
      color: Color.lerp(begin?.color, end?.color, t),
      value: (begin!.value + (end!.value - begin!.value) * t));
}
