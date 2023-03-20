import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_3_sk_kelahiran.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AdministrationCreatePage2SKKelahiranArgument {
  AdministrationType admType;
  AdministrationCreatePage2SKKelahiranArgument({required this.admType});
}

class AdministrationCreatePage2SKKelahiran extends StatefulWidget {
  static const String id = 'AdministrationCreatePage2SKKelahiran';
  AdministrationCreatePage2SKKelahiranArgument args;
  AdministrationCreatePage2SKKelahiran({Key? key, required this.args})
      : super(key: key);

  @override
  State<AdministrationCreatePage2SKKelahiran> createState() =>
      _AdministrationCreatePage2SKKelahiranState();
}

class _AdministrationCreatePage2SKKelahiranState
    extends State<AdministrationCreatePage2SKKelahiran> {
  User user = AuthProvider.currentUser!;
  final _TECCreatorFullname = TextEditingController();
  final _TECCreatorAnakKe = TextEditingController();
  final _TECCreatorBornPlace = TextEditingController();
  final _TECCreatorBornDate = TextEditingController();
  String _TECCreatorGender = '';
  AdministrationType? admType;
  String titleExplain = '';
  String detailExplain = '';
  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];
  int idxGender = 0;

  void getData() async {
    _TECCreatorGender = genderItems[0];

    admType = widget.args.admType;
    titleExplain = 'DATA ANAK';
    detailExplain =
        'Isilah semua form dibawah ini! Pastikan data anak sudah sesuai dan valid!';

    setState(() {});
  }

  void selanjutnya() async {
    if (cekData()) {
      AdministrationCreatePage3SKKelahiranArgument args =
          AdministrationCreatePage3SKKelahiranArgument(
        admType: admType!,
        creatorFullname: _TECCreatorFullname.text,
        creatorAnakKe: _TECCreatorAnakKe.text,
        creatorBorndate: _TECCreatorBornDate.text,
        creatorBornplace: _TECCreatorBornPlace.text,
        creatorGender: _TECCreatorGender,
      );
      Navigator.pushNamed(context, AdministrationCreatePage3SKKelahiran.id,
          arguments: args);
    }
  }

  bool cekData() {
    if (_TECCreatorFullname.text.isEmpty ||
        _TECCreatorAnakKe.text.isEmpty ||
        _TECCreatorBornPlace.text.isEmpty ||
        _TECCreatorBornDate.text.isEmpty) {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
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
        title: Text('Buat Surat Pengantar [ 1 / 3 ]'),
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
                controller: _TECCreatorAnakKe,
                keyboardType: TextInputType.number,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Anak Ke-',
                ),
              ),
              SB_height15,
              DropdownButtonFormField2(
                value: genderItems[idxGender],
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Jenis Kelamin',
                  style: smartRTTextLargeBold_Primary,
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: smartRTPrimaryColor,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: smartRTTextNormal_Primary,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _TECCreatorGender = value.toString();
                  });
                },
                onSaved: (value) {
                  _TECCreatorGender = value.toString();
                },
              ),
              SB_height15,
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
                type: DateTimePickerType.dateTime,
                locale: const Locale('id', 'ID'),
                dateMask: 'dd MMMM yyyy HH:mm',
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
