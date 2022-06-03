import 'package:flutter/material.dart';

import '../../entity/polygon_model.dart';

class PolygonPainter extends CustomPainter {
  final int sides;
  final double size;

  PolygonPainter({required this.size, this.sides = 4});

  @override
  void paint(Canvas canvas, Size size) {

    final poligono = ModelPolygon(side: sides, size: this.size, polygonSize: PolygonSize.SIDE);
    poligono.draw(canvas: canvas,
      size: size,
      circle: false,
      point: true,
      radio: false,);
    poligono.imprime();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
