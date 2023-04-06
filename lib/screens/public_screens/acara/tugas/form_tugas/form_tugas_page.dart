import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class FormTugasPageArgument {
  int dataEventIdx;
  FormTugasPageArgument({required this.dataEventIdx});
}

class FormTugasPage extends StatefulWidget {
  static const String id = 'FormTugasPage';
  FormTugasPageArgument args;
  FormTugasPage({Key? key, required this.args}) : super(key: key);

  @override
  State<FormTugasPage> createState() => _FormTugasPageState();
}

class _FormTugasPageState extends State<FormTugasPage> {
  User user = AuthProvider.currentUser!;
  final _TECJudul = TextEditingController();
  final _TECDetail = TextEditingController();
  final _TECJumlahOrang = TextEditingController();
  final List<DropdownMenuItem> _listYesNo = [
    const DropdownMenuItem(
      value: '1',
      child: Text('Yes'),
    ),
    const DropdownMenuItem(
      value: '0',
      child: Text('No'),
    ),
  ];
  String _isGeneral = '1';

  bool isDateEndReadOnly = true;
  DateTime dateEnd = DateTime.now();

  void buat(int idEvent) async {
    if (_TECJudul.text == '' ||
        _TECDetail.text == '' ||
        _TECJumlahOrang.text == '') {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
    } else {
      if (int.parse(_TECJumlahOrang.text) < 1) {
        SmartRTSnackbar.show(context,
            message:
                'Pastikan jumlah orang yang dibutuhkan lebih besar sama dengan 1.',
            backgroundColor: smartRTErrorColor);
      } else {
        await context.read<EventProvider>().createTask(
            idEvent: idEvent,
            detail: _TECDetail.text,
            isGeneral: _isGeneral,
            jumlahWorker: _TECJumlahOrang.text,
            title: _TECJudul.text);
        Navigator.pop(context);
        SmartRTSnackbar.show(context,
            message: 'Berhasil membuat tugas !',
            backgroundColor: smartRTSuccessColor);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int dataEventIdx = widget.args.dataEventIdx;
    Event dataEvent =
        context.watch<EventProvider>().dataListEvent[dataEventIdx];
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ExplainPart(
                title: 'BUAT TUGAS',
                notes:
                    'Anda wajib mengisikan semua kolom yang tersedia! Anda masih dapat merubahnya hingga acara dimulai!',
              ),
              SB_height30,
              TextFormField(
                controller: _TECJudul,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Judul Tugas',
                ),
              ),
              SB_height15,
              TextFormField(
                maxLines: 5,
                controller: _TECDetail,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Keterangan Tugas',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECJumlahOrang,
                keyboardType: TextInputType.number,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Total Orang yang Dibutuhkan',
                ),
              ),
              SB_height15,
              Text(
                'Apakah dibuka untuk umum?',
                style: smartRTTextNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SB_height5,
              DropdownButtonFormField2(
                dropdownMaxHeight: 200,
                value: _listYesNo[0].value,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
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
                items: _listYesNo
                    .map((item) => DropdownMenuItem<String>(
                          value: item.value,
                          child: item.child,
                          enabled: item.enabled,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _isGeneral = value.toString();
                  });
                },
                onSaved: (value) {
                  _isGeneral = value.toString();
                },
              ),
              Text(
                  '*Jika iya maka semua warga di wilayah anda dapat mengambil tugas tersebut tanpa membutuhkan konfirmasi anda. Namun jika tidak dibuka untuk umum, maka yang ingin mengambil tugas tersebut, wajib di konfirmasi oleh anda terlebih dahulu.',
                  style: smartRTTextSmall),
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
            buat(dataEvent.id);
          },
          child: Text(
            'BUAT',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
