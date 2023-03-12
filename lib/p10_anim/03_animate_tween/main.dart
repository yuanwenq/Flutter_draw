/*
 * @Date: 2023-03-12
 * @Desc: 
 */
import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020/11/1
/// contact me by email 1981462002@qq.com
/// 说明:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pic_man.dart';

void main() {
  // 确定初始化
  WidgetsFlutterBinding.ensureInitialized();
  //横屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏显示
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
            body: Center(
          child: PicMan(),
        )));
  }
}
