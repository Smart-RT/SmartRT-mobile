import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_4.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class AdministrationCreatePage3Argument {
  AdministrationType admType;
  String creatorFullname;
  String creatorAddress;
  String creatorNoKTP;
  String creatorNoKK;
  AdministrationCreatePage3Argument({
    required this.admType,
    required this.creatorFullname,
    required this.creatorAddress,
    required this.creatorNoKTP,
    required this.creatorNoKK,
  });
}

class AdministrationCreatePage3 extends StatefulWidget {
  static const String id = 'AdministrationCreatePage3';
  AdministrationCreatePage3Argument args;
  AdministrationCreatePage3({Key? key, required this.args}) : super(key: key);

  @override
  State<AdministrationCreatePage3> createState() =>
      _AdministrationCreatePage3State();
}

class _AdministrationCreatePage3State extends State<AdministrationCreatePage3> {
  User user = AuthProvider.currentUser!;
  final _TECCreatorBornPlace = TextEditingController();
  final _TECCreatorBornDate = TextEditingController();
  AdministrationType? admType;
  String titleExplain = '';
  String detailExplain = '';

  void selanjutnya() async {
    if (cekData()) {
      AdministrationCreatePage4Argument args =
          AdministrationCreatePage4Argument(
        admType: widget.args.admType,
        creatorFullname: widget.args.creatorFullname,
        creatorAddress: widget.args.creatorAddress,
        creatorNoKTP: widget.args.creatorNoKTP,
        creatorNoKK: widget.args.creatorNoKK,
        creatorBornPlace: _TECCreatorBornPlace.text,
        creatorBornDate: _TECCreatorBornDate.text,
      );
      Navigator.pushNamed(context, AdministrationCreatePage4.id,
          arguments: args);
    }
  }

  bool cekData() {
    if (_TECCreatorBornDate.text.isEmpty || _TECCreatorBornPlace.text.isEmpty) {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
      return false;
    }
    return true;
  }

  void getData() async {
    admType = widget.args.admType;
    if (admType!.id == 5) {
      titleExplain = 'DATA ORANG YANG MENINGGAL (2)';
      detailExplain =
          'Isilah semua form dibawah ini! Pastikan data orang yang meninggal sesuai dengan KTP atau KK !';
    } else {
      titleExplain = 'DATA DIRI (2)';
      detailExplain =
          'Isilah semua form dibawah ini! Pastikan data diri anda sesuai dengan KTP atau KK !';
      _TECCreatorBornPlace.text = user.born_at ?? '';
      _TECCreatorBornDate.text = user.born_date.toString();
    }

    setState(() {});
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
        title: Text('Buat Surat Pengantar [ 2 / 4 ]'),
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
                controller: _TECCreatorBornPlace,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Tempat Lahir',
                ),
              ),
              SB_height15,
              DateTimePicker(
                type: DateTimePickerType.date,
                locale: const Locale('id', 'ID'),
                dateMask: 'dd MMMM yyyy',
                style: smartRTTextNormal_Primary,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                dateLabelText: 'Tanggal Lahir',
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
                controller: _TECCreatorBornDate,
              ),
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
