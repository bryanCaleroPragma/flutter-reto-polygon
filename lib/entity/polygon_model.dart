import 'dart:math';

import 'package:flutter/material.dart';

import '../util.dart';
import 'point_model.dart';

enum PolygonSize {
  SIDE,
  ABSOLUTE_DIAMETER,
  RELATIVE_DIAMETER,
}

class ModelPolygon {
  final PolygonSize polygonSize;
  int sides;
  double size;
  late double angle;
  late double angleInt;
  late double radio;
  late double apothem;
  late double area;
  late double perimetro;

  ModelPoint centro = ModelPoint();
  List<ModelPoint> puntos = [];

  ModelPolygon({
    required this.sides,
    required this.size,
    this.polygonSize = PolygonSize.SIDE,
  }) {
    /// Se calcula la apertura del angulo interno con base a la cantidad de aristas
    angle = 360 / sides;
    angleInt = 180 - angle;

    if( polygonSize ==  PolygonSize.ABSOLUTE_DIAMETER ) {
      radio = size / 2;
      size = Util.trigoFunc(sin, angle / 2) * radio * 2;
    } else if( polygonSize ==  PolygonSize.RELATIVE_DIAMETER ) {

    } else {
      /// Calculo el radio con base a la arista
      radio = (size / 2) / Util.trigoFunc(sin, angle / 2);
    }

    apothem = Util.trigoFunc(cos, angle / 2) * radio;
    area = ( apothem * size / 2 ) * sides;
    perimetro = size * sides;

    calcularPuntos(90);
  }

  /// Se calculan las coordenadas de cada punto
  void calcularPuntos([double baseAngle = 0]) {
    /// puntos calculados con base al angulo de apertura
    for (int i = 0; i < sides; i++) {
      double a = (i * angle) + baseAngle;
      a -= ((a / 360).floor() * 360);

      /// Se debe ajustar el angulo dentro de la circunferencia
      add(ModelPoint.offset(
        centro,
        radio,
        a,
      ));
    }
  }

  void add(ModelPoint p) {
    puntos.add(p);
  }

  /// Permite ajustar el centro del poligono
  /// Se modifican todos los puntos con base al movimiento del centro
  void moveCenter(double x, double y) {
    if (x > 0 && y > 0) {
      centro = ModelPoint(x, y);
      List<ModelPoint> nuevosPuntos = [];
      puntos.forEach((punto) {
        nuevosPuntos.add(ModelPoint(
          punto.x + x,
          punto.y + y,
        ));
      });
      puntos = nuevosPuntos;
    }
  }

  /// Dibuja el poligono
  /// [canvas]: en el cual se dibujará el poligono
  /// [size]: para recalcular el centro del poligono y transladarlo
  /// [circle]: Para dibujar el circulo que contiene al poligono
  /// [point]: Para dibujar los puntos
  void draw({
    required Canvas canvas,
    Size? size,
    bool circle = false,
    bool point = false,
    bool radio = false,
  }) {
    if (size != null) {
      moveCenter(size.width / 2, size.height / 2);
    }

    if (circle) {
      final paintC = Paint()
        ..strokeWidth = 1
        ..color = Colors.red
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(Offset(centro.x, centro.y), this.radio, paintC);
    }

    if (point) {
      final paintP = Paint()..color = Colors.black;
      final paintR = Paint()..color = const Color.fromARGB(255, 0, 255, 0);
      canvas.drawCircle(Offset(centro.x, centro.y), 2, paintP);
      puntos.forEach((punto) {
        canvas.drawCircle(Offset(punto.x, punto.y), 2, paintP);

        if (radio) {
          canvas.drawLine(
            Offset(centro.x, centro.y),
            Offset(punto.x, punto.y),
            paintR,
          );
        }
      });
    }

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path = Path();
    for (int i = 0; i < puntos.length; i++) {
      final p = puntos[i];
      if (i == 0) {
        path.moveTo(p.x, p.y);
      } else {
        path.lineTo(p.x, p.y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void imprime() {
    print("\nlados: $sides, arista $size, radio $radio, angulo $angle, angle interno $angleInt,\n apothem $apothem, area $area, perimetro $perimetro");
    /*puntos.forEach((element) {
      element.imprime();
    });*/
  }
}
