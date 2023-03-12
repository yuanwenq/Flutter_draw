import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_draw/util/coordinate_pro.dart';

void main() {
  runApp(PathHit());
}

class PathHit extends StatefulWidget {
  const PathHit({Key? key}) : super(key: key);

  @override
  State<PathHit> createState() => _PathHitState();
}

class _PathHitState extends State<PathHit> {
  ValueNotifier<Offset> pos = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: PathPainter(pos),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    print(details.localPosition);
    pos.value = details.localPosition;
  }
}

class PathPainter extends CustomPainter {
  Coordinate coordinate = Coordinate(step: 25);
  // DashPainter dashPainter = DashPainter();
  ValueNotifier<Offset> pos = ValueNotifier(Offset.zero);

  PathPainter(this.pos) : super(repaint: pos);

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paintBase(canvas, size);
    Paint paint = Paint()..style = PaintingStyle.stroke;
    Path path = Path()
      ..moveTo(0, 0)
      ..relativeLineTo(40, 40)
      ..relativeLineTo(0, -40)
      ..close();

    Matrix4 m4 = Matrix4.translationValues(size.width / 2, size.height / 2, 0);
    Matrix4 center = Matrix4.translationValues(20, 20, 0);
    Matrix4 back = Matrix4.translationValues(-20, -20, 0);

    Matrix4 rotateM4 = Matrix4.rotationZ(10 * pi / 180);
    Matrix4 scaleM4 = Matrix4.diagonal3Values(2, 2, 1);

    m4.multiply(center);
    m4.multiply(rotateM4);
    m4.multiply(scaleM4);
    m4.multiply(back);

    path = path.transform(m4.storage);

    bool contains = path.contains(pos.value);
    double strokeWidth = contains ? 2 : 1;
    Color color = contains ? Colors.orange : Colors.black;
    canvas.drawPath(
        path,
        paint
          ..strokeWidth = strokeWidth
          ..color = color);

    canvas.drawCircle(Offset(size.width / 2 + 20, size.height / 2 + 20), 2,
        Paint()..color = Colors.red);
  }

  // void drawHelp(Matrix4 m4, Matrix4 center, Matrix4 rotateM4, Matrix4 back,
  //     Path path, Canvas canvas) {
  //   Matrix4 m = m4.multiplied(center);
  //   m.multiplied(rotateM4);
  //   m.multiply(back);
  //   Path helpPath = path.transform(m.storage);
  //   dashPainter.paint(
  //       canvas,
  //       helpPath,
  //       Paint()
  //         ..color = Colors.red
  //         ..style = PaintingStyle.stroke
  //         ..strokeWidth = 1);
  // }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) => true;
}
