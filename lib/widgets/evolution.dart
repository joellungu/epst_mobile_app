import 'package:flutter/material.dart';

class Evolution extends CustomPainter {
  double y1 = 0, y2 = 0;
  //
  Evolution(this.y1, this.y2);
  //
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 5;
    //

    //
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
