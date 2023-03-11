import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_3.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class AdministrationCreatePage2Argument {
  AdministrationType admType;
  AdministrationCreatePage2Argument({required this.admType});
}

class AdministrationCreatePage2 extends StatefulWidget {
  static const String id = 'AdministrationCreatePage2';
  AdministrationCreatePage2Argument args;
  AdministrationCreatePage2({Key? key, required this.args}) : super(key: key);

  @override
  State<AdministrationCreatePage2> createState() =>
      _AdministrationCreatePage2State();
}

class _AdministrationCreatePage2State extends State<AdministrationCreatePage2> {
  User user = AuthProvider.currentUser!;
  final _TECCreatorFullname = TextEditingController();
  final _TECCreatorAddress = TextEditingController();
  final _TECCreatorNoKTP = TextEditingController();
  final _TECCreatorNoKK = TextEditingController();
  AdministrationType? admType;
  String titleExplain = '';
  String detailExplain = '';

  void getData() async {
    admType = widget.args.admType;
    if (admType!.id == 5) {
      titleExplain = 'DATA ORANG YANG MENINGGAL (1)';
      detailExplain =
          'Isilah semua form dibawah ini! Pastikan data orang yang meninggal sesuai dengan KTP atau KK !';
    } else {
      titleExplain = 'DATA DIRI (1)';
      detailExplain =
          'Isilah semua form dibawah ini! Pastikan data diri anda sesuai dengan KTP atau KK !';
      _TECCreatorFullname.text = user.full_name;
      _TECCreatorAddress.text = user.address ?? '';
      _TECCreatorNoKTP.text = user.nik ?? '';
      _TECCreatorNoKK.text = user.kk_num ?? '';
    }
    setState(() {});
  }

  void selanjutnya() async {
    if (cekData()) {
      AdministrationCreatePage3Argument args =
          AdministrationCreatePage3Argument(
        admType: admType!,
        creatorFullname: _TECCreatorFullname.text,
        creatorAddress: _TECCreatorAddress.text,
        creatorNoKTP: _TECCreatorNoKTP.text,
        creatorNoKK: _TECCreatorNoKK.text,
      );
      Navigator.pushNamed(context, AdministrationCreatePage3.id,
          arguments: args);
    }
  }

  bool cekData() {
    if (_TECCreatorFullname.text.isEmpty ||
        _TECCreatorAddress.text.isEmpty ||
        _TECCreatorNoKTP.text.isEmpty ||
        _TECCreatorNoKK.text.isEmpty) {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
      return false;
    } else if ((!StringFormat.isKTPKKFormat(_TECCreatorNoKTP.text) &&
            _TECCreatorNoKTP.text != '-') ||
        (!StringFormat.isKTPKKFormat(_TECCreatorNoKK.text) &&
            _TECCreatorNoKK.text != '-')) {
      SmartRTSnackbar.show(context,
          message: 'Pastikan data KTP dan/atau KK valid !',
          backgroundColor: smartRTErrorColor);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Surat Pengantar [ 1 / 4 ]'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExplainPart(
                title: titleExplain,
                notes: detailExplain,
              ),
              SB_height30,
              TextFormField(
                controller: _TECCreatorFullname,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorAddress,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              const Divider(
                thickness: 2,
                height: 50,
              ),
              TextFormField(
                controller: _TECCreatorNoKTP,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Nomor KTP',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorNoKK,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Nomor KK',
                ),
              ),
              SB_height15,
              Text(
                '*Jika anda belum mempunyai KTP / KK, maka anda dapat mengisikan dengan simbol "-"',
                style: smartRTTextNormal,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ))),
          onPressed: () {
            selanjutnya();
          },
          child: Text(
            'SELANJUTNYA',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
