
import 'package:intl/intl.dart';

class IntFormat {
  static int ageNow({required DateTime bornDate}) {
    DateTime dateTimeNow = DateTime.now();
    int bornDateInt_date = int.parse(DateFormat('d', 'id_ID').format(bornDate));
    int bornDateInt_month =
        int.parse(DateFormat('M', 'id_ID').format(bornDate));
    int bornDateInt_year = int.parse(DateFormat('y', 'id_ID').format(bornDate));

    int dateTimeNowInt_date =
        int.parse(DateFormat('d', 'id_ID').format(dateTimeNow));
    int dateTimeNowInt_month =
        int.parse(DateFormat('M', 'id_ID').format(dateTimeNow));
    int dateTimeNowInt_year =
        int.parse(DateFormat('y', 'id_ID').format(dateTimeNow));

    int result = dateTimeNowInt_year - bornDateInt_year;
    if ((dateTimeNowInt_month == bornDateInt_month &&
            dateTimeNowInt_date < bornDateInt_date) ||
        dateTimeNowInt_month < bornDateInt_month) {
      result = result - 1;
    }

    return result;
  }
}
