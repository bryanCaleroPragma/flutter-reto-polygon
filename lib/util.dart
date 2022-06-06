import 'dart:math';

class Util {
  static String EMAIL_REGEXP =
      r"^([a-z][a-z0-9\_\-\.]+[a-z0-9])@([a-z0-9]+)(\.[a-z0-9]{2,})+$";

  /*static String EMAIL_REGEXP =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";*/

  static String formatMoney(String? _money,
      [String _symbol = '\$',
      String _decimalSep = ',',
      String _thousandsSep = '.',
      String _millarSep = '\'']) {
    _money = _money == null || _money.isEmpty ? "0" : _money;

    // En caso de que el string de entrada tenga ceros ( 0 ) al inicio
    if (_money != "0") {
      _money = _money.replaceAll(RegExp(r'^0+'), '');
      // Se formatean los grupos de millares
      _money =
          _money.replaceAllMapped(RegExp(r'(\d)(?=(\d{6})+(?!\d))'), (match) {
        return '${match.group(1)}$_millarSep';
      });

      // Se formatean los grupos de miles
      _money =
          _money.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) {
        return '${match.group(1)}$_thousandsSep';
      });
    }
    return _symbol + _money;
  }

  static bool validateRegex(String regex, String? value) =>
      value != null && value.isNotEmpty && RegExp(regex).hasMatch(value);

  static bool validateEmail(String? value) =>
      validateRegex(EMAIL_REGEXP, value);

  static double degreesToRadians(double d) => d * pi / 180;

  static double trigoFunc(Function func, double degrees) =>
      func(degreesToRadians(degrees));

  static int cuadrante(double angle) {
    if (angle >= 0 && angle < 90) {
      return 1;
    } else if (angle >= 90 && angle < 180) {
      return 2;
    } else if (angle >= 180 && angle < 270) {
      return 3;
    } else {
      return 4;
    }
  }
}
