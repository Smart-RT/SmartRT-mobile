import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period_detail.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/arisan_provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';

class CreatePertemuanSelanjutnyaPage extends StatefulWidget {
  static const String id = 'CreatePertemuanSelanjutnyaPage';
  const CreatePertemuanSelanjutnyaPage({Key? key}) : super(key: key);

  @override
  State<CreatePertemuanSelanjutnyaPage> createState() =>
      _CreatePertemuanSelanjutnyaPageState();
}

class _CreatePertemuanSelanjutnyaPageState
    extends State<CreatePertemuanSelanjutnyaPage> {
  final _tempatPertemuanController = TextEditingController();
  final _tanggalPertemuanController = TextEditingController();
  String _periodeKe = '1';
  User user = AuthProvider.currentUser!;
  LotteryClubPeriodDetail? dataPertemuan;

  void getData() async {
    Response<dynamic> resp = await NetUtil().dioClient.get(
        '/lotteryClubs/getLastPeriodeID/${user.area!.lottery_club_id!.id.toString()}');
    int idPeriodeTerakhir = resp.data;
    resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getPeriodDetail/Unpublished/${idPeriodeTerakhir}');

    dataPertemuan = LotteryClubPeriodDetail.fromData(resp.data);

    _periodeKe = dataPertemuan!.lottery_club_period_id!.meet_ctr.toString();
    _tempatPertemuanController.text = dataPertemuan!.meet_at ??
        'Rumah Pak RT (${user.area!.ketua_id!.address})';
    _tanggalPertemuanController.text = dataPertemuan!.meet_date.toString();

    debugPrint('tempat : ${_tempatPertemuanController}');
    debugPrint('tanggal : ${_tanggalPertemuanController}');

    setState(() {});
  }

  void simpan(bool isPublikasi) async {
    String statusPublikasi;
    String msg;
    if (isPublikasi) {
      statusPublikasi = 'Published';
      msg = 'menyimpan perubahan dan mempublikasikan';
    } else {
      statusPublikasi = 'Unpublished';
      msg = 'menyimpan perubahan';
    }
    bool isUpdatePertemuanSukses = await context
        .read<ArisanProvider>()
        .updatePertemuan(
            context: context,
            lotteryClubPeriodDetailID: dataPertemuan!.id.toString(),
            tempatPertemuan: _tempatPertemuanController.text,
            tanggalPertemuan: DateTime.parse(_tanggalPertemuanController.text),
            statusPublikasi: statusPublikasi);
    if (isUpdatePertemuanSukses) {
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, ArisanPage.id);
      SmartRTSnackbar.show(context,
          message: 'Berhasil ${msg} pertemuan arisan!',
          backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: 'Gagal! Cobalah beberapa saat lagi!',
          backgroundColor: smartRTErrorColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ExplainPart(title: 'PERTEMUAN KE-${_periodeKe}', notes: ''),
                  SB_height15,
                  TextFormField(
                    controller: _tempatPertemuanController,
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Tempat Pertemuan',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                    },
                  ),
                  SB_height15,
                  DateTimePicker(
                    controller: _tanggalPertemuanController,
                    type: DateTimePickerType.dateTime,
                    dateMask: 'yyyy/MM/dd HH:mm',
                    style: smartRTTextNormal_Primary,
                    initialDate: dataPertemuan == null
                        ? DateTime.now().add(Duration(days: 10))
                        : dataPertemuan!.meet_date,
                    firstDate: dataPertemuan == null
                        ? DateTime.now().add(Duration(days: 10))
                        : dataPertemuan!.meet_date,
                    lastDate: dataPertemuan == null
                        ? DateTime.now().add(Duration(days: 70))
                        : dataPertemuan!.created_at.add(Duration(days: 70)),
                    dateLabelText: 'Tanggal Pertemuan',
                    onChanged: (val) => print(val),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Tanggal Pertemuan tidak boleh kosong";
                      }
                    },
                    onSaved: (val) => print(val),
                  ),
                  SB_height30,
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    simpan(false);
                  },
                  child: Text(
                    'SIMPAN',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
              SB_height15,
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    simpan(true);
                  },
                  child: Text(
                    'SIMPAN DAN PUBLIKASIKAN',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
