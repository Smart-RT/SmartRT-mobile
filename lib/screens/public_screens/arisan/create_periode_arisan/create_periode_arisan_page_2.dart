import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';

class CreatePeriodeArisanPage2 extends StatefulWidget {
  static const String id = 'CreatePeriodeArisanPage2';
  const CreatePeriodeArisanPage2({Key? key}) : super(key: key);

  @override
  State<CreatePeriodeArisanPage2> createState() =>
      _CreatePeriodeArisanPage2State();
}

class _CreatePeriodeArisanPage2State extends State<CreatePeriodeArisanPage2> {
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
                  const ExplainPart(title: 'Periode Ke-X', notes: ''),
                  SB_height15,
                  TextFormField(
                    initialValue: '6' + ' Orang',
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
                    },
                  ),
                  SB_height15,
                  TextFormField(
                    initialValue: '0.5' + ' Tahun',
                    readOnly: true,
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Panjang Periode',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                    },
                  ),
                  SB_height15,
                  TextFormField(
                    initialValue: '6' + ' Pertemuan',
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
                    },
                  ),
                  SB_height15,
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'yyyy/MM/dd',
                    style: smartRTTextNormal_Primary,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    dateLabelText: 'Tanggal Mulai',
                    onChanged: (val) => print(val),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Tanggal Mulai tidak boleh kosong";
                      }
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
                    initialValue: 'Rp ' + '10.000',
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Tagihan Pertemuan',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tagihan Pertemuan tidak boleh kosong';
                      }
                    },
                  ),
                  SB_height15,
                  TextFormField(
                    initialValue: 'Rp' + '60.000',
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
                    },
                  ),
                  SB_height30,
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {},
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
    );
  }
}
