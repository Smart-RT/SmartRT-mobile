import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/health/health_task_help.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class HealthProvider extends ChangeNotifier {
  List<HealthTaskHelp> listHealthTaskHelp = [];
  List<UserHealthReport> listUserHealthReport = [];

  Map<String, Future> futures = {};

  void updateListener() => notifyListeners();

  Future<bool> getListUserHealthReport({required BuildContext context}) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/health/userReported/all/status');
      listUserHealthReport.clear();
      listUserHealthReport.addAll((resp.data).map<UserHealthReport>((request) {
        return UserHealthReport.fromData(request);
      }));
      notifyListeners();
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

  Future<bool> getHealthTaskHelps(
      {required BuildContext context, required String is_all}) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/health/healthTaskHelp/list/is-all/${is_all}');
      listHealthTaskHelp.clear();
      listHealthTaskHelp.addAll((resp.data).map<HealthTaskHelp>((request) {
        return HealthTaskHelp.fromData(request);
      }));
      notifyListeners();
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

  Future<bool> melaporkanKesehatan({
    required BuildContext context,
    required int reported_id_for,
    required int area_reported_id,
    required int disease_group_id,
    required int disease_level,
    required String disease_notes,
    required String type,
  }) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.post('/health/userReporting', data: {
        "reported_id_for": reported_id_for,
        "area_reported_id": area_reported_id,
        "disease_group_id": disease_group_id,
        "disease_level": disease_level,
        "disease_notes": disease_notes,
      });
      if (type == 'DIRI SENDIRI') {
        AuthProvider.currentUser!.is_health = 0;
        notifyListeners();
        context.read<AuthProvider>().saveUserDataToStorage();
      }
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

  Future<bool> sayaSehat({
    required BuildContext context,
  }) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.patch('/health/userReported/sayaSehat');

      AuthProvider.currentUser!.is_health = 1;
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
