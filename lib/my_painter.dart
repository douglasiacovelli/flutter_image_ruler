import 'package:flutter/material.dart';
import 'package:size_calculator/canvas_controller.dart';

class MyPainter extends CustomPainter {
  final CanvasController controller;

  MyPainter(this.controller) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final path = Path();

    int i = 0;
    for (var point in controller.points) {
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
        path.moveTo(point.dx, point.dy);
      }
      canvas.drawCircle(point, 5, paint);
      i += 1;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
