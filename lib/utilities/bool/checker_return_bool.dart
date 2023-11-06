
class CheckerReturnBool {
  static bool isDate1AfterDate2(
      {required DateTime dt1, required DateTime dt2}) {
    if (dt1.compareTo(dt2) > 0) {
      return true;
    }
    return false;
  }

  static bool isDate1BeforeDate2(
      {required DateTime dt1, required DateTime dt2}) {
    if (dt1.compareTo(dt2) < 0) {
      return true;
    }
    return false;
  }

  static bool isDate1SameDate2({required DateTime dt1, required DateTime dt2}) {
    if (dt1.compareTo(dt2) == 0) {
      return true;
    }
    return false;
  }

  static bool isDate1BetweenDate2AndDate3(
      {required DateTime dt1, required DateTime dt2, required DateTime dt3}) {
    if (dt1.compareTo(dt2) >= 0 && dt1.compareTo(dt3) <= 0) {
      return true;
    }
    return false;
  }
}
