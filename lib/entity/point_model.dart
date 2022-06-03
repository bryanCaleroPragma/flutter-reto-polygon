import '../util.dart';

class ModelPoint {
  final double x;
  final double y;
  final double ox;
  final double oy;

  const ModelPoint([this.x = 0, this.y = 0, this.ox = 0, this.oy = 0]);

  /// Se calcula el punto desfasado con base a otro punto de referencia
  /// en función del angulo desde el cual fué calculado
  factory ModelPoint.offset(ModelPoint p, double x, double y, [double a = 0]) {
    int c = Util.cuadrante(a);
    return ModelPoint(
      p.x + (x.abs() * (c == 1 || c == 4 ? 1 : -1)),
      p.y + (y.abs() * (c == 3 || c == 4 ? 1 : -1)),
      x.abs(),
      y.abs(),
    );
  }

  void imprime() {
    print("PUNTO ( $x [ $ox ], $y [ $oy ] )");
  }
}