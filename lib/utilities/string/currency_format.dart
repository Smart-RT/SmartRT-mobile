import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(int number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'IDR ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
