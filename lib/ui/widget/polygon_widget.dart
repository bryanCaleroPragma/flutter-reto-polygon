import 'package:flutter/material.dart';

import 'line_painter.dart';

class Polygon extends StatelessWidget {
  int sides;
  double size;
  bool relative;

  Polygon({Key? key, this.sides = 3, this.size = 10, this.relative = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.purple),
      ),
      width: 500,
      height: 500,
      child: CustomPaint(
        foregroundPainter: PolygonPainter(
          size: size,
          sides: sides,
        ),
      ),
    );
  }
}
