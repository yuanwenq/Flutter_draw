/*
 * @Date: 2023-03-12
 * @Desc: 
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'handle_widget.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _rotate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: _rotate,
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                width: 100,
                height: 100,
              ),
            ),
            HandleWidget(
              onMove: _onMove,
            ),
          ],
        ),
      ),
    );
  }

  void _onMove(double rotate, double distance) {
    setState(() {
      _rotate = rotate;
    });
  }
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
        home: HomePage());
  }
}
