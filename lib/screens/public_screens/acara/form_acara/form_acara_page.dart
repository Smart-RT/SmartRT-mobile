import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class FormAcaraPageArgument {
  String type;
  int? dataEventIdx;
  FormAcaraPageArgument({required this.type, this.dataEventIdx});
}

class FormAcaraPage extends StatefulWidget {
  static const String id = 'FormAcaraPage';
  FormAcaraPageArgument args;
  FormAcaraPage({Key? key, required this.args}) : super(key: key);

  @override
  State<FormAcaraPage> createState() => _FormAcaraPageState();
}

class _FormAcaraPageState extends State<FormAcaraPage> {
  User user = AuthProvider.currentUser!;
  final _TECJudul = TextEditingController();
  final _TECDetail = TextEditingController();
  final _TECDateStart = TextEditingController();
  final _TECDateEnd = TextEditingController();
  int? idEvent;
  bool isDateEndReadOnly = true;
  DateTime dateEnd = DateTime.now();

  void buat() async {
    DateTime dtStart = DateTime.now();
    DateTime dtEnd = DateTime.now();
    if (_TECDateStart.text != '' && _TECDateEnd.text != '') {
      dtStart = DateTime.parse(_TECDateStart.text);
      dtEnd = DateTime.parse(_TECDateEnd.text);
    }

    if (_TECJudul.text == '' ||
        _TECDetail.text == '' ||
        _TECDateStart.text == '' ||
        _TECDateEnd.text == '') {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
    } else if (dtStart.compareTo(dtEnd) > 0 || dtStart.compareTo(dtEnd) == 0) {
      SmartRTSnackbar.show(context,
          message:
              'Pastikan Tanggal dan Waktu Selesai lebih besar dari pada Tanggal dan Waktu Mulai !',
          backgroundColor: smartRTErrorColor);
    } else {
      await context.read<EventProvider>().createEvent(
          title: _TECJudul.text,
          detail: _TECDetail.text,
          dateEnd: _TECDateEnd.text,
          dateStart: _TECDateStart.text);
      Navigator.pop(context);
      SmartRTSnackbar.show(context,
          message: 'Berhasil membuat event !',
          backgroundColor: smartRTSuccessColor);
    }
  }

  void ubah() async {
    if (_TECJudul.text == '' || _TECDetail.text == '') {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
    } else {
      await context.read<EventProvider>().updateEvent(
          idEvent: idEvent!, title: _TECJudul.text, detail: _TECDetail.text);
      Navigator.pop(context);
      SmartRTSnackbar.show(context,
          message: 'Berhasil memperbarui event !',
          backgroundColor: smartRTSuccessColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String type = widget.args.type;
    String txtBtn = '';
    if (type == 'update') {
      int dataEventIdx = widget.args.dataEventIdx!;
      Event dataEvent =
          context.watch<EventProvider>().dataListEvent[dataEventIdx];
      idEvent = dataEvent.id;
      _TECJudul.text = dataEvent.title;
      _TECDetail.text = dataEvent.detail;
      _TECDateStart.text = DateFormat('d MMMM y HH:mm', 'id_ID')
          .format(dataEvent.event_date_start_at);
      _TECDateEnd.text = DateFormat('d MMMM y HH:mm', 'id_ID')
          .format(dataEvent.event_date_end_at);
      txtBtn = 'UBAH';
    } else {
      txtBtn = 'BUAT';
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ExplainPart(
                title: 'BUAT ACARA',
                notes:
                    'Anda wajib mengisikan semua kolom yang telah disediakan! Anda masih dapat merubahnya hingga acara acara dimulai kecuali tanggal dan waktu. Setelah acara dimulai, anda sudah tidak dapat merubah apapun!',
              ),
              SB_height30,
              if (type == 'create')
                DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  locale: const Locale('id', 'ID'),
                  dateMask: 'dd MMMM yyyy HH:mm',
                  style: smartRTTextNormal_Primary,
                  firstDate: DateTime.now().add(const Duration(days: 3)),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  initialDate: DateTime.now().add(const Duration(days: 3)),
                  dateLabelText: 'Tanggal dan Waktu Mulai',
                  onChanged: (val) {
                    isDateEndReadOnly = false;
                    dateEnd = DateTime.parse(val);
                    setState(() {});
                  },
                  onSaved: (val) {
                    isDateEndReadOnly = false;
                    dateEnd = DateTime.parse(val!);
                    setState(() {});
                  },
                  controller: _TECDateStart,
                ),
              if (type == 'create') SB_height15,
              if (type == 'create')
                DateTimePicker(
                  readOnly: isDateEndReadOnly,
                  type: DateTimePickerType.dateTime,
                  locale: const Locale('id', 'ID'),
                  dateMask: 'dd MMMM yyyy HH:mm',
                  style: smartRTTextNormal_Primary,
                  firstDate: dateEnd,
                  lastDate: dateEnd,
                  initialDate: dateEnd,
                  dateLabelText: 'Tanggal dan Waktu Selesai',
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                  controller: _TECDateEnd,
                ),
              if (type == 'create')
                const Divider(
                  height: 50,
                  thickness: 5,
                ),
              TextFormField(
                controller: _TECJudul,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Judul Acara',
                ),
              ),
              SB_height15,
              TextFormField(
                maxLines: 10,
                controller: _TECDetail,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Detail Acara',
                ),
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
            type == 'update' ? ubah() : buat();
          },
          child: Text(
            txtBtn,
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
