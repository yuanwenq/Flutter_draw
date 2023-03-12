/*
 * @Date: 2023-03-12
 * @Desc: 
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_draw/util/coordinate.dart';

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  // double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(progress: _ctrl),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Animation<double> progress;
  final Coordinate coordinate = Coordinate(step: 25);

  PaperPainter({required this.progress}) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paintBase(canvas, size);

    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      Tangent? tangent = pm.getTangentForOffset(pm.length * progress.value);
      if (tangent == null) return;
      canvas.drawCircle(
          tangent.position, 5, Paint()..color = Colors.deepOrange);
    });

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
