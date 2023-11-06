import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/lottery_club/lottery_club.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class ArisanProvider extends ChangeNotifier {
  Future<bool> bukaArisan({
    required BuildContext context,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil().dioClient.post('/lotteryClubs/');
      AuthProvider.currentUser!.area!.lottery_club_id =
          LotteryClub.fromData(resp.data);
      notifyListeners();
      context.read<AuthProvider>().saveUserDataToStorage();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<bool> bukaPeriode({
    required BuildContext context,
    required int bill_amount,
    required int winner_bill_amount,
    required String year_limit,
    required int total_meets,
    required List<int> members,
    required DateTime started_at,
  }) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.post('/lotteryClubs/periode', data: {
        "bill_amount": bill_amount,
        "winner_bill_amount": winner_bill_amount,
        "year_limit": year_limit,
        "total_meets": total_meets,
        "members": members,
        "started_at": started_at,
      });
      AuthProvider.currentUser!.area!.is_lottery_club_period_active = 1;
      AuthProvider.currentUser!.is_lottery_club_member = true;
      notifyListeners();
      context.read<AuthProvider>().saveUserDataToStorage();
      debugPrint(AuthProvider.currentUser!.area!.is_lottery_club_period_active
          .toString());
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<bool> updatePertemuan(
      {required BuildContext context,
      required String lotteryClubPeriodDetailID,
      required String tempatPertemuan,
      required DateTime tanggalPertemuan,
      required String statusPublikasi}) async {
    try {
      await NetUtil().dioClient.patch('/lotteryClubs/periode/pertemuan', data: {
        "lottery_club_period_detail_id": lotteryClubPeriodDetailID,
        "meet_date": tanggalPertemuan,
        "meet_at": tempatPertemuan,
        "status": statusPublikasi
      });
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }
}
