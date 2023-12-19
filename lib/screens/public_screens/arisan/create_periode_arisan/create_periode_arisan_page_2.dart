import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/arisan_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';

class CreatePeriodeArisanPage2Arguments {
  List<int> listMemberID;
  CreatePeriodeArisanPage2Arguments({required this.listMemberID});
}

class CreatePeriodeArisanPage2 extends StatefulWidget {
  static const String id = 'CreatePeriodeArisanPage2';
  CreatePeriodeArisanPage2Arguments args;
  CreatePeriodeArisanPage2({Key? key, required this.args}) : super(key: key);

  @override
  State<CreatePeriodeArisanPage2> createState() =>
      _CreatePeriodeArisanPage2State();
}

class _CreatePeriodeArisanPage2State extends State<CreatePeriodeArisanPage2> {
  final _formKey = GlobalKey<FormState>();
  final _jumlahAnggotaController = TextEditingController();
  final _totalPertemuanController = TextEditingController();
  final _tanggalMulaiController = TextEditingController();
  final _tagihanPertemuanController = TextEditingController();
  final _hadiahPemenangController = TextEditingController();
  List<int> _listMemberID = [];
  int _listMemberIDLength = 6;
  List<String> _panjangPeriode = [];
  String _panjangPeriodeSelectedValue = '';
  String periodeNext = '0';

  void getData() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get('/lotteryClubs/getLastPeriode');
    periodeNext = resp.data.toString();
  }

  void clearAll() {
    _listMemberID.clear();
    _panjangPeriode.clear();
    _panjangPeriodeSelectedValue = '';
    _listMemberIDLength = 6;
    _jumlahAnggotaController.text = '';
    _totalPertemuanController.text = '';
    _tanggalMulaiController.text = '';
    _tagihanPertemuanController.text = '';
    _hadiahPemenangController.text = '';
  }

  void filledAll() {
    _listMemberID = widget.args.listMemberID;
    _listMemberIDLength = _listMemberID.length;
    if (_listMemberIDLength >= 6 && _listMemberIDLength <= 11) {
      _panjangPeriode.add('0.5');
      _totalPertemuanController.text = '6';
    } else if (_listMemberIDLength == 12) {
      _panjangPeriode.add('0.5');
      _panjangPeriode.add('1');
      _totalPertemuanController.text = '6';
    } else if (_listMemberIDLength >= 13 && _listMemberIDLength <= 23) {
      _panjangPeriode.add('1');
      _totalPertemuanController.text = '12';
    } else if (_listMemberIDLength == 24) {
      _panjangPeriode.add('1');
      _panjangPeriode.add('2');
      _totalPertemuanController.text = '12';
    } else if (_listMemberIDLength >= 25 && _listMemberIDLength <= 35) {
      _panjangPeriode.add('2');
      _totalPertemuanController.text = '24';
    } else if (_listMemberIDLength == 36) {
      _panjangPeriode.add('2');
      _panjangPeriode.add('3');
      _totalPertemuanController.text = '24';
    } else if (_listMemberIDLength >= 35 && _listMemberIDLength <= 47) {
      _panjangPeriode.add('3');
      _totalPertemuanController.text = '36';
    } else if (_listMemberIDLength == 48) {
      _panjangPeriode.add('3');
      _panjangPeriode.add('4');
      _totalPertemuanController.text = '36';
    }
    _jumlahAnggotaController.text = _listMemberIDLength.toString();
    _tagihanPertemuanController.text = '5000';
    _hadiahPemenangController.text =
        (int.parse(_tagihanPertemuanController.text) * _listMemberIDLength)
            .toString();
  }

  bool checkDataValid() {
    if (_tagihanPertemuanController.text == '' ||
        _hadiahPemenangController.text == '' ||
        _tanggalMulaiController.text == '' ||
        _totalPertemuanController.text == '' ||
        _jumlahAnggotaController.text == '' ||
        _panjangPeriodeSelectedValue == '') {
      return false;
    }
    return true;
  }

  void bukaPeriode() async {
    if (checkDataValid()) {
      bool bukaPeriodeArisanSukses = await context
          .read<ArisanProvider>()
          .bukaPeriode(
              context: context,
              bill_amount: int.parse(_tagihanPertemuanController.text),
              winner_bill_amount: int.parse(_hadiahPemenangController.text),
              year_limit: _panjangPeriodeSelectedValue,
              total_meets: int.parse(_totalPertemuanController.text),
              members: _listMemberID,
              started_at: DateTime.parse(_tanggalMulaiController.text));
      if (bukaPeriodeArisanSukses) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, ArisanPage.id);
        SmartRTSnackbar.show(context,
            message: 'Berhasil membuat periode arisan!',
            backgroundColor: smartRTSuccessColor);
      } else {
        SmartRTSnackbar.show(context,
            message: 'Gagal membuat! Cobalah beberapa saat lagi!',
            backgroundColor: smartRTErrorColor);
      }
    } else {
      SmartRTSnackbar.show(context,
          message: 'Data tidak valid!', backgroundColor: smartRTErrorColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    clearAll();
    filledAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: paddingScreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ExplainPart(title: 'Periode Ke-$periodeNext', notes: ''),
                    SB_height15,
                    TextFormField(
                      controller: _jumlahAnggotaController,
                      readOnly: true,
                      autocorrect: false,
                      style: smartRTTextNormal_Primary,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Anggota',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SB_height15,
                    Text(
                      'Panjang Periode (dalam Tahun)',
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SB_height5,
                    DropdownButtonFormField2(
                      value: _panjangPeriode[0],
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
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
                      buttonPadding: const EdgeInsets.only(right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      items: _panjangPeriode
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: smartRTTextNormal_Primary,
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Panjang Periode tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _panjangPeriodeSelectedValue = value.toString();
                          if (_panjangPeriodeSelectedValue == '0.5') {
                            _totalPertemuanController.text = '6';
                          } else if (_panjangPeriodeSelectedValue == '1') {
                            _totalPertemuanController.text = '12';
                          } else if (_panjangPeriodeSelectedValue == '2') {
                            _totalPertemuanController.text = '24';
                          } else if (_panjangPeriodeSelectedValue == '3') {
                            _totalPertemuanController.text = '36';
                          } else if (_panjangPeriodeSelectedValue == '4') {
                            _totalPertemuanController.text = '48';
                          }
                        });
                      },
                      onSaved: (value) {
                        _panjangPeriodeSelectedValue = value.toString();
                      },
                    ),
                    SB_height15,
                    TextFormField(
                      controller: _totalPertemuanController,
                      // initialValue: '${_totalPertemuan} Pertemuan',
                      readOnly: true,
                      autocorrect: false,
                      style: smartRTTextNormal_Primary,
                      decoration: const InputDecoration(
                        labelText: 'Total Pertemuan',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SB_height15,
                    DateTimePicker(
                      controller: _tanggalMulaiController,
                      type: DateTimePickerType.dateTime,
                      locale: const Locale('id', 'ID'),
                      dateMask: 'yyyy/MM/dd HH:mm',
                      style: smartRTTextNormal_Primary,
                      initialDate: DateTime.now().add(Duration(days: 10)),
                      firstDate: DateTime.now().add(Duration(days: 10)),
                      lastDate: DateTime.now().add(Duration(days: 70)),
                      dateLabelText: 'Tanggal Mulai',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Tanggal Mulai tidak boleh kosong";
                        }
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                    SB_height30,
                    const ExplainPart(
                        title: 'Keuangan',
                        notes:
                            'Jumlah hadiah untuk pemenang yaitu senilai total anggota arisan periode ini dikalikan dengan jumlah tagihan perorang setiap pertemuan.'),
                    SB_height30,
                    TextFormField(
                      controller: _tagihanPertemuanController,
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      style: smartRTTextNormal_Primary,
                      decoration: const InputDecoration(
                        labelText: 'Tagihan Pertemuan (dalam Rp)',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _hadiahPemenangController.text =
                              (_listMemberIDLength * int.parse(value))
                                  .toString();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tagihan Pertemuan tidak boleh kosong';
                        } else if (int.parse(value) <= 5000) {
                          return 'Tagihan Pertemuan tidak boleh dibawah 5000';
                        }
                        return null;
                      },
                    ),
                    SB_height15,
                    TextFormField(
                      controller: _hadiahPemenangController,
                      readOnly: true,
                      autocorrect: false,
                      style: smartRTTextNormal_Primary,
                      decoration: const InputDecoration(
                        labelText: 'Hadiah Pemenang',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hadiah Pemenang tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SB_height30,
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bukaPeriode();
                    },
                    child: Text(
                      'SELESAI DAN BUAT',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
