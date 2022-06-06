import 'dart:math';

import '../util.dart';

class ModelPoint {
  final double x;
  final double y;
  final double ox;
  final double oy;

  const ModelPoint([this.x = 0, this.y = 0, this.ox = 0, this.oy = 0]);

  /// Se calcula el punto desfasado con base a otro punto de referencia
  /// en función del angulo desde el cual fué calculado
  factory ModelPoint.offset(ModelPoint p, double radio, [double a = 0]) {
    int c = Util.cuadrante(a);
    double x = (Util.trigoFunc(cos, a) * radio).abs();
    double y = (Util.trigoFunc(sin, a) * radio).abs();
    return ModelPoint(
      p.x + (x * (c == 1 || c == 4 ? 1 : -1)),
      p.y + (y * (c == 3 || c == 4 ? 1 : -1)),
      x,
      y,
    );
  }

  void imprime() {
    print("PUNTO ( $x [ $ox ], $y [ $oy ] )");
  }
}
