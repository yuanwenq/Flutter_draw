/*
 * @Date: 2023-03-08
 * @Desc: 
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_draw/p05_Rect/paper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]); // 使设备横屏显示
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: []); // 全屏显示
  runApp(Paper());
}
