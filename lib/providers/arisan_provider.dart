import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/lottery_club.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class ArisanProvider extends ChangeNotifier {
  Future<bool> bukaArisan({
    required BuildContext context,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil().dioClient.post('/lotteryClubs');
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
}
